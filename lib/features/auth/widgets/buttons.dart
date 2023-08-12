import 'package:flutter/material.dart';
import 'package:gazprom_test/core/colors.dart';
import 'package:gazprom_test/core/fonts.dart';
import 'package:gazprom_test/core/widgets.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.isLoad,
    required this.onPressed,
  });

  final bool isLoad;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      'Войти',
      style: b1FontMedium,
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: _style,
        child: isLoad ? const Loader(size: 24, width: 4) : label,
      ),
    );
  }

  ButtonStyle get _style {
    const padding = EdgeInsets.all(12);
    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    );

    return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(padding),
      backgroundColor: MaterialStateProperty.all<Color?>(primary),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(border),
    );
  }
}
