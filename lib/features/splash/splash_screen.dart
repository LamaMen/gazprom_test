import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazprom_test/core/fonts.dart';
import 'package:gazprom_test/features/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(const AppOpenedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 7, 0, 255),
              Color(0xFF000000),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is NavigateToLoginState) {
              Navigator.pushReplacementNamed(context, '/login');
            }

            if (state is NavigateToWeather) {
              Navigator.pushReplacementNamed(context, '/weather');
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'WEATHER SERVICE',
                          style: maxFont,
                        )),
                  ),
                ),
                Text('dawn is coming soon', style: minFont),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
