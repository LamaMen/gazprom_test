import 'package:flutter/material.dart';
import 'package:gazprom_test/core/colors.dart';
import 'package:gazprom_test/core/fonts.dart';

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
      style: b1FontMedium.copyWith(color: white),
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: _style,
        child: isLoad ? const _Loader() : label,
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

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 4,
        color: white,
      ),
    );
  }
}
