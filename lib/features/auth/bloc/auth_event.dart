part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent implements AuthEvent {
  const LoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
