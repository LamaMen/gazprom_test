import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazprom_test/core/widgets.dart';
import 'package:gazprom_test/features/weather/bloc/weather_bloc.dart';
import 'package:gazprom_test/features/weather/domain/models/weather_info.dart';
import 'package:gazprom_test/features/weather/widgets/additional_info_view.dart';
import 'package:gazprom_test/features/weather/widgets/all_weather_view.dart';
import 'package:gazprom_test/features/weather/widgets/current_weather.dart';
import 'package:gazprom_test/features/weather/widgets/place_title.dart';
import 'package:gazprom_test/features/weather/widgets/weather_failure_body.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(const GetWeatherEvent());
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is SuccessState) {
              return _WeatherBody(state.weatherInfo);
            }

            if (state is FailedState) {
              return WeatherFailureBody(state.failure);
            }

            return const Center(child: Loader(size: 48, width: 4));
          },
        ),
      ),
    );
  }
}

class _WeatherBody extends StatelessWidget {
  const _WeatherBody(this.weather);

  final WeatherInfo weather;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            PlaceTitle(weather.place),
            const SizedBox(height: 24),
            Expanded(child: CurrentWeather(weather.current)),
            const SizedBox(height: 24),
            AllWeatherView(
              weathers: weather.nearest,
              current: weather.currentWeather,
            ),
            const SizedBox(height: 24),
            AdditionalInfoView(weather.current),
          ],
        ),
      ),
    );
  }
}
