import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazprom_test/core/colors.dart';
import 'package:gazprom_test/core/fonts.dart';
import 'package:gazprom_test/features/weather/domain/models/weather.dart';

class AdditionalInfoView extends StatelessWidget {
  const AdditionalInfoView(this.weather, {super.key});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 96,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          _AdditionInfoRow(
            icon: 'assets/wind.svg',
            value: weather.wind.value,
            title: weather.wind.direction,
          ),
          const SizedBox(height: 16),
          _AdditionInfoRow(
            icon: 'assets/humidity.svg',
            value: weather.humidity.value,
            title: weather.humidity.title,
          ),
        ],
      ),
    );
  }
}

class _AdditionInfoRow extends StatelessWidget {
  const _AdditionInfoRow({
    required this.icon,
    required this.value,
    required this.title,
  });

  final String icon;
  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(icon),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: b2FontMedium.copyWith(color: transparentWhite),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            title,
            style: b2Font.copyWith(color: white),
          ),
        ),
      ],
    );
  }
}
