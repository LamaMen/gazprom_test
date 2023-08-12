part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeatherEvent implements WeatherEvent {
  const GetWeatherEvent();
}

class ChangeCurrentWeatherEvent implements WeatherEvent {
  const ChangeCurrentWeatherEvent(this.index);

  final int index;
}
