part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class InitialState implements WeatherState {
  const InitialState();
}

class LoadWeatherState implements WeatherState {
  const LoadWeatherState();
}

class SuccessState implements WeatherState {
  const SuccessState(this.weatherInfo);

  final WeatherInfo weatherInfo;
}

class FailedState implements WeatherState {
  const FailedState(this.failure);

  final Failure failure;
}
