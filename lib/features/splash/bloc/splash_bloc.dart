import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazprom_test/features/splash/domain/check_user_usecase.dart';
import 'package:gazprom_test/features/weather/data/services/weather_database_client.dart';
import 'package:injectable/injectable.dart';

part 'splash_event.dart';

part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this._isUserLoggedIn,
    this._weatherDatabase,
  ) : super(const InitialState()) {
    on<AppOpenedEvent>(onAppOpened);
  }

  final CheckUserUseCase _isUserLoggedIn;
  final WeatherDatabaseClient _weatherDatabase;

  Future<void> onAppOpened(AppOpenedEvent event, Emitter emit) async {
    await Future.delayed(const Duration(seconds: 1));
    if (await _isUserLoggedIn()) {
      await _weatherDatabase.deleteOldWeather();
      emit(const NavigateToWeather());
    } else {
      emit(const NavigateToLoginState());
    }
  }
}
