import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazprom_test/core/colors.dart';
import 'package:gazprom_test/core/fonts.dart';
import 'package:gazprom_test/features/weather/domain/models/place.dart';

class PlaceTitle extends StatelessWidget {
  const PlaceTitle(this.place, {super.key});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset('assets/map_mark.svg'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            place.title,
            style: b2FontMedium.copyWith(color: white),
          ),
        ),
      ],
    );
  }
}
