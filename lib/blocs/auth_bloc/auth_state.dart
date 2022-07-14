part of 'auth_bloc.dart';

class AuthState {
  final UserModel? currentUser;
  final bool signinLoading;
  final bool signupLoading;

  const AuthState({
    required this.currentUser,
    required this.signinLoading,
    required this.signupLoading,
  });

  const AuthState.defaultState()
      : currentUser = null,
        signinLoading = false,
        signupLoading = false;
}
