import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazprom_test/core/colors.dart';
import 'package:gazprom_test/core/fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text('Вход', style: h1Font),
              const SizedBox(height: 12),
              Text(
                'Введите данные для входа',
                style: b2Font.copyWith(color: greyText),
              ),
              const SizedBox(height: 12),
              _EmailField(controller: emailController),
              const SizedBox(height: 24),
              _PasswordField(controller: passwordController),
              const SizedBox(height: 54),
              const _LoginButton(isLoad: false),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: primaryRed,
      decoration: InputDecoration(
        label: Text('Email', style: b1Font.copyWith(color: greyText)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: stroke),
        ),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField({required this.controller});

  final TextEditingController controller;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      controller: widget.controller,
      cursorColor: primaryRed,
      decoration: InputDecoration(
        label: Text('Пароль', style: b1Font.copyWith(color: greyText)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: stroke),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: isObscure
              ? SvgPicture.asset('assets/eye.svg')
              : SvgPicture.asset('assets/eye_off.svg'),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
    required this.isLoad,
  }) : super(key: key);

  final bool isLoad;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: _style,
        child: isLoad
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: Colors.white,
                ),
              )
            : Text(
                'Войти',
                style: b1FontMedium.copyWith(color: Colors.white),
              ),
      ),
    );
  }

  ButtonStyle get _style {
    return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
        const EdgeInsets.all(12),
      ),
      backgroundColor: MaterialStateProperty.all<Color?>(primary),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
