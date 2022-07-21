import 'dart:io';

import 'package:chatapp/enums/snackbar_message.dart';
import 'package:chatapp/global_widgets.dart';
import 'package:chatapp/services/storage_service.dart';
import 'package:chatapp/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState.initial()) {
    on<PickImageEvent>((event, emit) {
      emit(ProfileState(imageFile: event.imageFile, isLoading: false));
    });
    on<UpdateProfileEvent>((event, emit) async {
      // Starts Loading
      try {
        emit(ProfileState(imageFile: state.imageFile, isLoading: true));

        Map<String, dynamic> dataToUpdate = {'name': event.name};

        String? downloadUrl;
        if (state.imageFile != null) {
          downloadUrl = await StorageService.uploadFile(
            file: state.imageFile!,
            path: 'profile_images/${event.uid}',
          );
          dataToUpdate['profileImage'] = downloadUrl;
        }

        await UserService.updateProifle(
            uid: event.uid, dataToUpdate: dataToUpdate);

        emit(const ProfileState.initial());
        showSnackbar(SnackbarMessage.success, 'Profile Updated.');
      } on FirebaseException catch (e) {
        emit(ProfileState(imageFile: state.imageFile, isLoading: false));
        showSnackbar(SnackbarMessage.error, e.message ?? e.toString());
      } catch (e) {
        emit(ProfileState(imageFile: state.imageFile, isLoading: false));
        showSnackbar(SnackbarMessage.error, e.toString());
      }
    });
  }
}
