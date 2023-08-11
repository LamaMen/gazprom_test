import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazprom_test/core/colors.dart';
import 'package:gazprom_test/core/injection.dart';
import 'package:gazprom_test/features/weather/bloc/weather_bloc.dart';
import 'package:gazprom_test/features/weather/weather_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await initializeDateFormatting();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gazprom Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => getIt<WeatherBloc>(),
        child: const WeatherScreen(),
      ),
      // home: BlocProvider(
      //   create: (context) => getIt<AuthBloc>(),
      //   child: const AuthScreen(),
      // ),
    );
  }
}
