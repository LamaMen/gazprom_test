part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class InitialAuthState implements AuthState {
  const InitialAuthState();
}

class LoginProcessState implements AuthState {
  const LoginProcessState();
}

class LoginSuccessState implements AuthState {
  const LoginSuccessState();
}

class LoginFailedState implements AuthState {
  const LoginFailedState(this.failure);

  final Failure failure;
}
