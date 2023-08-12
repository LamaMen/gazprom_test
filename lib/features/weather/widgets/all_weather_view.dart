import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazprom_test/core/colors.dart';
import 'package:gazprom_test/core/fonts.dart';
import 'package:gazprom_test/features/weather/bloc/weather_bloc.dart';
import 'package:gazprom_test/features/weather/domain/models/weather.dart';
import 'package:intl/intl.dart';

class AllWeatherView extends StatelessWidget {
  const AllWeatherView({
    super.key,
    required this.weathers,
    required this.current,
  });

  final List<Weather> weathers;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 231,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          const _DateView(),
          const Divider(height: 1, color: white),
          _WeathersRow(weathers, current),
        ],
      ),
    );
  }
}

class _DateView extends StatelessWidget {
  const _DateView();

  String get date {
    final date = DateTime.now();
    final formatter = DateFormat('d MMMM', 'ru');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text('Сегодня', style: b1FontMedium),
          const Spacer(),
          Text(date, style: b2Font),
        ],
      ),
    );
  }
}

class _WeathersRow extends StatelessWidget {
  const _WeathersRow(this.weathers, this.current);

  final List<Weather> weathers;
  final int current;

  @override
  Widget build(BuildContext context) {
    final List<Widget> views = [];
    for (final (i, item) in weathers.indexed) {
      views.add(Expanded(
        child: _Weather(
          weather: item,
          isCurrent: i == current,
          index: i,
        ),
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: views,
      ),
    );
  }
}

class _Weather extends StatelessWidget {
  const _Weather({
    required this.weather,
    required this.isCurrent,
    required this.index,
  });

  final Weather weather;
  final bool isCurrent;
  final int index;

  @override
  Widget build(BuildContext context) {
    final time = DateTime.fromMillisecondsSinceEpoch(weather.rawDate * 1000);
    final formatter = DateFormat.Hm();
    final temp = weather.temp.round();

    return InkWell(
      onTap: () {
        context.read<WeatherBloc>().add(ChangeCurrentWeatherEvent(index));
      },
      child: Container(
        height: 142,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCurrent ? milky : null,
          border: isCurrent ? Border.all(width: 1.0, color: white) : null,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            Text(formatter.format(time), style: b2Font),
            Expanded(child: SvgPicture.asset(weather.smallIconPath)),
            Text('$tempº', style: b1FontMedium),
          ],
        ),
      ),
    );
  }
}
