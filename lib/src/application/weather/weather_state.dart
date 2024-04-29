part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  const WeatherState({
    this.locationAccessStatus = const StatusInitial(),
    this.userLocation,
    this.cityName,
    this.weatherData,
    this.forecastData,
    this.forcastStatus = const StatusInitial(),
  });

  final Status locationAccessStatus;
  final Position? userLocation;
  final String? cityName;
  final WeatherData? weatherData;
  final ForecastData? forecastData;
  final Status forcastStatus;

  @override
  List<Object?> get props => [
        locationAccessStatus,
        userLocation,
        cityName,
        weatherData,
        forecastData,
        forcastStatus,
      ];

  WeatherState copyWith({
    Status? locationAccessStatus,
    Position? userLocation,
    String? cityName,
    WeatherData? weatherData,
    ForecastData? forecastData,
    Status? forcastStatus,
  }) {
    return WeatherState(
      locationAccessStatus: locationAccessStatus ?? this.locationAccessStatus,
      userLocation: userLocation ?? this.userLocation,
      cityName: cityName ?? this.cityName,
      weatherData: weatherData ?? this.weatherData,
      forecastData: forecastData ?? this.forecastData,
      forcastStatus: forcastStatus ?? this.forcastStatus,
    );
  }
}
