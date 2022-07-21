part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent();
}

@immutable
class PickImageEvent implements ProfileEvent {
  final File imageFile;
  const PickImageEvent({required this.imageFile});
}

@immutable
class UpdateProfileEvent implements ProfileEvent {
  final String uid;
  final String name;
  const UpdateProfileEvent({required this.name, required this.uid});
}
