import 'dart:convert';

import 'package:coffee_shop/src/domain/core/failures/api_failure.dart';
import 'package:coffee_shop/src/domain/core/models/forecast_data/forecast_data.dart';
import 'package:coffee_shop/src/domain/core/models/weather_data/weather_data.dart';
import 'package:coffee_shop/src/domain/weather/i_weather_repostitory.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton(as: IWeatherRepository)
class WeatherRepository implements IWeatherRepository {
  WeatherRepository(this.client);
  final http.Client client;

  @override
  Future<Position> getUserLocation() {
    try {
      return determineUserLocation();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeatherData> getWeatherData({
    required String latitude,
    required String longitude,
  }) async {
    try {
      const apiId = '3b672e333fbd9e3e17a6221ae5d3dc62';
      final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiId',
      );
      final response = await client.get(uri);

      final data = json.decode(response.body) as Map<String, dynamic>;
      return WeatherData.fromJson(data);
    } on ApiFailure {
      rethrow;
    } catch (e) {
      throw ApiFailure();
    }
  }

  @override
  Future<ForecastData> getWeatherForecastData({
    required String latitude,
    required String longitude,
  }) async {
    try {
      const apiId = 'e41258954a88cd161a0e827bfcd3c923';
      final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiId',
      );
      final response = await client.get(uri);
      final data = json.decode(response.body) as Map<String, dynamic>;
      return ForecastData.fromJson(data);
    } on ApiFailure {
      rethrow;
    } catch (e) {
      throw ApiFailure();
    }
  }
}

Future<Position> determineUserLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permission denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'PERMA_DENIED',
    );
  }

  final position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return position;
}
