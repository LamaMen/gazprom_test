import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazprom_test/core/colors.dart';
import 'package:gazprom_test/core/fonts.dart';
import 'package:gazprom_test/features/auth/bloc/auth_bloc.dart';
import 'package:gazprom_test/features/auth/widgets/buttons.dart';
import 'package:gazprom_test/features/auth/widgets/fields.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  bool get isValidFields => _formKey.currentState!.validate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final failure = state is LoginFailedState ? state.failure : null;

              return Form(
                key: _formKey,
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
                    EmailField(
                      controller: emailController,
                      failure: failure,
                    ),
                    const SizedBox(height: 24),
                    PasswordField(
                      controller: passwordController,
                      failure: failure,
                    ),
                    const SizedBox(height: 54),
                    LoginButton(
                      isLoad: state is LoginProcessState,
                      onPressed: _checkUserData,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _checkUserData() {
    FocusScope.of(context).unfocus();
    if (!isValidFields) return;

    final event = LoginEvent(
      email: emailController.text,
      password: passwordController.text,
    );
    context.read<AuthBloc>().add(event);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
