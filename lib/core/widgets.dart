import 'package:flutter/material.dart';
import 'package:gazprom_test/core/colors.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    required this.size,
    required this.width,
  });

  final double size;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: width,
        color: white,
      ),
    );
  }
}
