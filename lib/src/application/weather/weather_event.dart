part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class GetUserLocationEvent extends WeatherEvent {}

class GetWeatherDataEvent extends WeatherEvent {
  const GetWeatherDataEvent({required this.lat, required this.lng});

  final String lat;
  final String lng;
  @override
  List<Object?> get props => [lat, lng];
}

class GetForeCastWeatherDataEvent extends WeatherEvent {}
