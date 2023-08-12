import 'package:flutter/material.dart';
import 'package:gazprom_test/core/fonts.dart';
import 'package:gazprom_test/features/weather/domain/models/weather.dart';
import 'package:intl/intl.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather(this.current, {super.key});

  final Weather current;

  @override
  Widget build(BuildContext context) {
    final temp = current.temp.round();
    final description = toBeginningOfSentenceCase(current.description, 'ru')!;
    final minTemp = 'Мин: ${current.tempMin.round()}º';
    final maxTemp = 'Макс: ${current.tempMax.round()}º';

    return Column(
      children: [
        Expanded(child: _WeatherImage(current.largeIconPath)),
        Text('$tempº', style: largeFont),
        Text(description, style: b1Font),
        const SizedBox(height: 8),
        Text('$maxTemp $minTemp', style: b1Font),
      ],
    );
  }
}

class _WeatherImage extends StatelessWidget {
  const _WeatherImage(this.path);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned.fill(
        //   child: Container(
        //     decoration: const BoxDecoration(
        //       gradient: RadialGradient(
        //         colors: [violet, Colors.transparent],
        //       ),
        //     ),
        //   ),
        // ),
        Image.asset(path),
      ],
    );
  }
}
