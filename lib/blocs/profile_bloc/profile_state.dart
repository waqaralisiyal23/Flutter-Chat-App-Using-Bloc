part of 'profile_bloc.dart';

@immutable
class ProfileState {
  final File? imageFile;
  final bool isLoading;

  const ProfileState({
    required this.imageFile,
    required this.isLoading,
  });

  const ProfileState.initial()
      : imageFile = null,
        isLoading = false;
}
