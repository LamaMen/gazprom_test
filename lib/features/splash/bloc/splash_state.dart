part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class InitialState implements SplashState {
  const InitialState();
}

class NavigateToLoginState implements SplashState {
  const NavigateToLoginState();
}

class NavigateToWeather implements SplashState {
  const NavigateToWeather();

}
