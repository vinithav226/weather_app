// Create an interface for a repository like this

import 'package:coffee_shop/src/domain/core/models/forecast_data/forecast_data.dart';
import 'package:coffee_shop/src/domain/core/models/weather_data/weather_data.dart';
import 'package:geolocator/geolocator.dart';

abstract class IWeatherRepository {
  Future<Position> getUserLocation();
  Future<WeatherData> getWeatherData({
    required String latitude,
    required String longitude,
  });
  Future<ForecastData> getWeatherForecastData({
    required String latitude,
    required String longitude,
  });
}
