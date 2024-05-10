import 'dart:async';

import 'package:coffee_shop/src/application/core/status.dart';
import 'package:coffee_shop/src/domain/core/failures/api_failure.dart';
import 'package:coffee_shop/src/domain/core/models/forecast_data/forecast_data.dart';
import 'package:coffee_shop/src/domain/core/models/weather_data/weather_data.dart';
import 'package:coffee_shop/src/domain/weather/i_weather_repostitory.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._authRepository) : super(const WeatherState()) {
    on<GetUserLocationEvent>(_onGetUserLocationEvent);
    on<GetWeatherDataEvent>(_onGetWeatherDataEvent);
    on<GetForeCastWeatherDataEvent>(_onGetForeCastWeatherDataEvent);
  }

  final IWeatherRepository _authRepository;

  FutureOr<void> _onGetUserLocationEvent(
    GetUserLocationEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(
      state.copyWith(
        locationAccessStatus: StatusLoading(),
      ),
    );
    //Get latitude & longitude
    try {
      final position = await _authRepository.getUserLocation();

      emit(
        state.copyWith(
          userLocation: position,
        ),
      );
      final city = await decodeLocationInfo(
        state.userLocation?.latitude ?? 0,
        state.userLocation?.longitude ?? 0,
      );
      add(
        GetWeatherDataEvent(
          lat: state.userLocation?.latitude.toString() ?? '0',
          lng: state.userLocation?.longitude.toString() ?? '0',
        ),
      );
      emit(
        state.copyWith(
          cityName: city,
        ),
      );
    } on ApiFailure catch (e) {
      emit(state.copyWith(locationAccessStatus: StatusFailure(e.toString())));
    }
  }

  Future<String> decodeLocationInfo(double latitude, double longitude) async {
    final coordinate = await placemarkFromCoordinates(latitude, longitude);

    if (coordinate.isNotEmpty) {
      return coordinate.first.locality.toString();
    }
    return '';
  }

  FutureOr<void> _onGetWeatherDataEvent(
    GetWeatherDataEvent event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          locationAccessStatus: StatusLoading(),
        ),
      );
      final currentWeatherData = await _authRepository.getWeatherData(
        latitude: event.lat,
        longitude: event.lng,
      );
      emit(
        state.copyWith(
          weatherData: currentWeatherData,
          locationAccessStatus: StatusSuccess(),
        ),
      );
    } on ApiFailure catch (e) {
      emit(state.copyWith(locationAccessStatus: StatusFailure(e.toString())));
    }
  }

  FutureOr<void> _onGetForeCastWeatherDataEvent(
    GetForeCastWeatherDataEvent event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          forcastStatus: StatusLoading(),
        ),
      );
      final data = await _authRepository.getWeatherForecastData(
        latitude: state.userLocation?.latitude.toString() ?? '',
        longitude: state.userLocation?.longitude.toString() ?? '',
      );
      emit(
        state.copyWith(
          forecastData: data,
          forcastStatus: StatusSuccess(),
        ),
      );
    } on ApiFailure catch (e) {
      emit(state.copyWith(forcastStatus: StatusFailure(e.toString())));
    }
  }
}
