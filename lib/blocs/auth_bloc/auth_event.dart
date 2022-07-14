part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

@immutable
class SelectRouteEvent implements AuthEvent {}

@immutable
class SignInEvent implements AuthEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});
}

@immutable
class SignUpEvent implements AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

@immutable
class LogOutEvent implements AuthEvent {}
