import 'package:coffee_shop/src/domain/core/models/forecast_data/city.dart';
import 'package:coffee_shop/src/domain/core/models/forecast_data/forecast.dart';
import 'package:equatable/equatable.dart';

class ForecastData extends Equatable {
  const ForecastData({
    this.cod,
    this.message,
    this.cnt,
    this.forecast,
    this.city,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) => ForecastData(
        cod: json['cod'] as String?,
        message: json['message'] as int?,
        cnt: json['cnt'] as int?,
        forecast: (json['list'] as List<dynamic>?)
            ?.map((e) => Forecast.fromJson(e as Map<String, dynamic>))
            .toList(),
        city: json['city'] == null
            ? null
            : City.fromJson(json['city'] as Map<String, dynamic>),
      );
  final String? cod;
  final int? message;
  final int? cnt;
  final List<Forecast>? forecast;
  final City? city;

  Map<String, dynamic> toJson() => {
        'cod': cod,
        'message': message,
        'cnt': cnt,
        'list': forecast?.map((e) => e.toJson()).toList(),
        'city': city?.toJson(),
      };

  ForecastData copyWith({
    String? cod,
    int? message,
    int? cnt,
    List<Forecast>? forecast,
    City? city,
  }) {
    return ForecastData(
      cod: cod ?? this.cod,
      message: message ?? this.message,
      cnt: cnt ?? this.cnt,
      forecast: forecast ?? this.forecast,
      city: city ?? this.city,
    );
  }

  @override
  List<Object?> get props => [cod, message, cnt, forecast, city];
}
