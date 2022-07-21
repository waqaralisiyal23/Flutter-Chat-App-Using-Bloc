import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/enums/snackbar_message.dart';
import 'package:chatapp/global_widgets.dart';
import 'package:chatapp/screens/auth/signup_or_signin_screen.dart';
import 'package:chatapp/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:chatapp/helpers/local_storage.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.defaultState()) {
    on<SelectRouteEvent>(_onSelectRouteEvent);
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<RefreshCurrentUserEvent>(_onRefreshCurrentUserEvent);
    on<LogOutEvent>(_onLogOutEvent);
  }

  void _onSelectRouteEvent(
    SelectRouteEvent event,
    Emitter<AuthState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    if (FirebaseAuth.instance.currentUser == null) {
      if (LocalStorage.hasCurrentUser()) {
        await LocalStorage.removeCurrentUser();
      }
      Get.offAllNamed(SignupOrSigninScreen.name);
    } else {
      if (LocalStorage.hasCurrentUser()) {
        emit(
          AuthState(
            currentUser: LocalStorage.readUser(),
            signinLoading: false,
            signupLoading: false,
          ),
        );
        Get.offAllNamed(HomeScreen.name);
      } else {
        await FirebaseAuth.instance.signOut();
        Get.offAllNamed(SignupOrSigninScreen.name);
      }
    }
  }

  void _onSignInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    if (validateSignIn(event)) {
      // start Loading
      emit(
        const AuthState(
          currentUser: null,
          signinLoading: true,
          signupLoading: false,
        ),
      );

      try {
        User? user = await AuthService.signIn(event.email, event.password);
        if (user != null) {
          UserModel? userModel = await UserService.getUserDetails(user.uid);
          if (userModel != null) {
            await LocalStorage.saveUser(userModel);

            emit(
              AuthState(
                currentUser: userModel,
                signinLoading: false,
                signupLoading: false,
              ),
            );

            Get.offAllNamed(HomeScreen.name);
          } else {
            await FirebaseAuth.instance.signOut();
            emit(const AuthState.defaultState());
            showSnackbar(
                SnackbarMessage.error, 'Failed to retrieve user record.');
          }
        } else {
          emit(const AuthState.defaultState());
          showSnackbar(SnackbarMessage.error, 'Unknown Error Occured.');
        }
      } on FirebaseAuthException catch (e) {
        emit(const AuthState.defaultState());
        showSnackbar(SnackbarMessage.error, e.message ?? e.toString());
      } on FirebaseException catch (e) {
        emit(const AuthState.defaultState());
        showSnackbar(SnackbarMessage.error, e.message ?? e.toString());
      } catch (e) {
        emit(const AuthState.defaultState());
        showSnackbar(SnackbarMessage.error, e.toString());
      }
    }
  }

  void _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    if (validateSignUp(event)) {
      // start Loading
      emit(
        const AuthState(
          currentUser: null,
          signinLoading: false,
          signupLoading: true,
        ),
      );

      try {
        User? user = await AuthService.signUp(event.email, event.password);
        if (user != null) {
          UserModel userModel = UserModel(
            uid: user.uid,
            name: event.name,
            email: event.email,
            status: true,
          );
          await UserService.saveUser(userModel);
          await LocalStorage.saveUser(userModel);

          emit(
            AuthState(
              currentUser: userModel,
              signinLoading: false,
              signupLoading: false,
            ),
          );

          Get.offAllNamed(HomeScreen.name);
        } else {
          emit(const AuthState.defaultState());
          showSnackbar(SnackbarMessage.error, 'Unknown Error Occured.');
        }
      } on FirebaseAuthException catch (e) {
        emit(const AuthState.defaultState());
        showSnackbar(SnackbarMessage.error, e.message ?? e.toString());
      } on FirebaseException catch (e) {
        emit(const AuthState.defaultState());
        showSnackbar(SnackbarMessage.error, e.message ?? e.toString());
      } catch (e) {
        emit(const AuthState.defaultState());
        showSnackbar(SnackbarMessage.error, e.toString());
      }
    }
  }

  void _onRefreshCurrentUserEvent(
      RefreshCurrentUserEvent event, Emitter<AuthState> emit) async {
    emit(
      AuthState(
        currentUser: event.userModel,
        signinLoading: false,
        signupLoading: false,
      ),
    );
  }

  void _onLogOutEvent(LogOutEvent event, Emitter<AuthState> emit) async {
    try {
      await UserService.updateProifle(
        uid: state.currentUser!.uid,
        dataToUpdate: {'status': false},
      );
      await FirebaseAuth.instance.signOut();
      await LocalStorage.removeCurrentUser();
      emit(const AuthState.defaultState());
      Get.offAllNamed(SignupOrSigninScreen.name);
    } on FirebaseAuthException catch (e) {
      showSnackbar(SnackbarMessage.error, e.message ?? e.toString());
    } on FirebaseException catch (e) {
      showSnackbar(SnackbarMessage.error, e.message ?? e.toString());
    } catch (e) {
      showSnackbar(SnackbarMessage.error, e.toString());
    }
  }

  bool validateSignIn(SignInEvent event) {
    if (event.email.isEmpty && event.password.isEmpty) {
      showSnackbar(
          SnackbarMessage.missing, 'Please enter your email and password.');
      return false;
    } else if (event.email.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter your email.');
      return false;
    } else if (event.password.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter your password.');
      return false;
    } else if (!GetUtils.isEmail(event.email)) {
      showSnackbar(SnackbarMessage.error, 'Invalid Email.');
      return false;
    } else {
      return true;
    }
  }

  bool validateSignUp(SignUpEvent event) {
    if (event.name.isEmpty && event.email.isEmpty && event.password.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please fill all details.');
      return false;
    } else if (event.name.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter name.');
      return false;
    } else if (event.email.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter email.');
      return false;
    } else if (event.password.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter password.');
      return false;
    } else if (!GetUtils.isEmail(event.email)) {
      showSnackbar(SnackbarMessage.error, 'Invalid Email.');
      return false;
    } else {
      return true;
    }
  }
}
