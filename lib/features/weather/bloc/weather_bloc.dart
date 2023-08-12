import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazprom_test/core/failure.dart';
import 'package:gazprom_test/features/weather/domain/usecases/get_weather_usecase.dart';
import 'package:gazprom_test/features/weather/domain/models/weather_info.dart';
import 'package:injectable/injectable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._getWeather) : super(const InitialState()) {
    on<GetWeatherEvent>(onWeatherLoaded);
  }

  final GetWeatherUseCase _getWeather;

  Future<void> onWeatherLoaded(GetWeatherEvent event, Emitter emit) async {
    emit(const LoadWeatherState());
    final result = await _getWeather();

    emit(result.fold(
      (f) => FailedState(f),
      (w) => SuccessState(w),
    ));
  }
}
