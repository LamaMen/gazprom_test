import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gazprom_test/features/weather/data/models/weather_list_dto_remote.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'weather_api_client.g.dart';

@module
abstract class RegisterModule {
  WeatherApiClient get weatherClient {
    final dio = Dio();
    dio.interceptors.add(_allMessagesInterceptor);
    return WeatherApiClient(dio);
  }

  LogInterceptor get _allMessagesInterceptor {
    return LogInterceptor(
      logPrint: _logPrint,
      error: true,
      requestBody: true,
      responseHeader: true,
      request: true,
      requestHeader: true,
      responseBody: true,
    );
  }

  void _logPrint(Object object) => log(object.toString());
}

@RestApi(baseUrl: 'http://api.openweathermap.org/data/2.5')
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio) = _WeatherApiClient;

  @GET("/forecast")
  Future<WeatherListDtoRemote> fetchWeather(
    @Query("lat") double lat,
    @Query("lon") double lon, [
    @Query("appid") String apikey = '79d298ef85f365588ab37ddde21e58f9',
    @Query("units") String units = 'metric',
    @Query("lang") String lang = 'ru',
  ]);
}
