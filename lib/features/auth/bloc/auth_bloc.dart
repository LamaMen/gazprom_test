import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazprom_test/core/failure.dart';
import 'package:gazprom_test/features/auth/domain/login_usecase.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._login) : super(const InitialAuthState()) {
    on<LoginEvent>(onLogin);
  }

  final LoginUseCase _login;

  Future<void> onLogin(LoginEvent event, Emitter emit) async {
    emit(const LoginProcessState());
    final result = await _login(event.email, event.password);

    emit(result.fold(
      (f) => LoginFailedState(f),
      (_) => const LoginSuccessState(),
    ));
  }
}
