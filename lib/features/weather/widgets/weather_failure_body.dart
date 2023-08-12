import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazprom_test/core/colors.dart';
import 'package:gazprom_test/core/failure.dart';
import 'package:gazprom_test/core/fonts.dart';
import 'package:gazprom_test/features/weather/bloc/weather_bloc.dart';
import 'package:gazprom_test/features/weather/domain/failures.dart';

class WeatherFailureBody extends StatelessWidget {
  const WeatherFailureBody(this.failure, {super.key});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    late final String error;

    if (failure is LocationServiceDisabledFailure) {
      error =
          'Геолокация выключена на телефоне, включите её и попробуйте снова.';
    } else if (failure is LocationPermissionDeniedFailure) {
      error =
          'Для работы приложения необходимо получить разрешение на получение геолокации.';
    } else if (failure is LocationPermissionDeniedForeverFailure) {
      error =
          'Для работы приложения необходимо получить разрешение на получение геолокации. Разрешите приложению получать геолокацию в настройках устройства';
    } else if (failure is InternetFailure) {
      error =
          'Приложению не удалось получить информацию об погоде. Проверьте подключение к интернету и повторите попытку.';
    } else {
      error = 'Произошла неизвестная ошибка.';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.2),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Text('Произошла ошибка', style: h2Font),
              const SizedBox(height: 8),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Text(error, style: b1Font),
                ),
              ),
              const _ReloadButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<WeatherBloc>().add(const GetWeatherEvent());
        },
        style: _style,
        child: Text(
          'Попробовать снова',
          style: b1FontMedium,
        ),
      ),
    );
  }

  ButtonStyle get _style {
    const padding = EdgeInsets.all(12);
    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(padding),
      backgroundColor: MaterialStateProperty.all<Color?>(primary),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(border),
    );
  }
}
