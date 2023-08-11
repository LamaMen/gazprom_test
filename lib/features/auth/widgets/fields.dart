import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazprom_test/core/colors.dart';
import 'package:gazprom_test/core/failure.dart';
import 'package:gazprom_test/core/fonts.dart';
import 'package:gazprom_test/features/auth/domain/failure.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.controller,
    this.failure,
  });

  final Failure? failure;
  final TextEditingController controller;

  String? get error {
    if (failure is NoSuchUserFailure) {
      return 'Не существует пользователя с таким email';
    }

    if (failure is WrongEmailFormatFailure) {
      return 'Неверный формат';
    }

    if (failure is InternetFailure) {
      return 'Отсутствует подключение к интернету';
    }

    if (failure is UnknownFailure) {
      return 'Неизвестная ошибка, проверьте данные';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: (value) =>
          value == null || value.isNotEmpty ? null : 'Введите email',
      cursorColor: primaryRed,
      decoration: InputDecoration(
        errorText: error,
        label: Text('Email', style: b1Font.copyWith(color: greyText)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: stroke),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.failure,
  });

  final Failure? failure;
  final TextEditingController controller;

  String? get error {
    if (failure is WrongPasswordFailure) {
      return 'Неверный пароль';
    }

    return null;
  }

  @override
  State<PasswordField> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;

  String get iconPath => isObscure ? 'assets/eye.svg' : 'assets/eye_off.svg';

  void _changePasswordVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      controller: widget.controller,
      validator: (value) =>
          value == null || value.isNotEmpty ? null : 'Введите пароль',
      cursorColor: primaryRed,
      decoration: InputDecoration(
        errorText: widget.error,
        label: Text('Пароль', style: b1Font.copyWith(color: greyText)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: stroke),
        ),
        suffixIcon: IconButton(
          onPressed: _changePasswordVisibility,
          icon: SvgPicture.asset(iconPath),
        ),
      ),
    );
  }
}
