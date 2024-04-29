import 'package:coffee_shop/src/domain/core/models/forecast_data/clouds.dart';
import 'package:coffee_shop/src/domain/core/models/forecast_data/main.dart';
import 'package:coffee_shop/src/domain/core/models/forecast_data/rain.dart';
import 'package:coffee_shop/src/domain/core/models/forecast_data/sys.dart';
import 'package:coffee_shop/src/domain/core/models/forecast_data/weather.dart';
import 'package:coffee_shop/src/domain/core/models/forecast_data/wind.dart';
import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  const Forecast({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
    this.rain,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        dt: json['dt'] as int?,
        main: json['main'] == null
            ? null
            : Main.fromJson(json['main'] as Map<String, dynamic>),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        clouds: json['clouds'] == null
            ? null
            : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
        wind: json['wind'] == null
            ? null
            : Wind.fromJson(json['wind'] as Map<String, dynamic>),
        visibility: json['visibility'] as int?,
        pop: (json['pop'] as num?)?.toDouble(),
        sys: json['sys'] == null
            ? null
            : Sys.fromJson(json['sys'] as Map<String, dynamic>),
        dtTxt: json['dt_txt'] as String?,
        rain: json['rain'] == null
            ? null
            : Rain.fromJson(json['rain'] as Map<String, dynamic>),
      );
  final int? dt;
  final Main? main;
  final List<Weather>? weather;
  final Clouds? clouds;
  final Wind? wind;
  final int? visibility;
  final double? pop;
  final Sys? sys;
  final String? dtTxt;
  final Rain? rain;

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'main': main?.toJson(),
        'weather': weather?.map((e) => e.toJson()).toList(),
        'clouds': clouds?.toJson(),
        'wind': wind?.toJson(),
        'visibility': visibility,
        'pop': pop,
        'sys': sys?.toJson(),
        'dt_txt': dtTxt,
        'rain': rain?.toJson(),
      };

  Forecast copyWith({
    int? dt,
    Main? main,
    List<Weather>? weather,
    Clouds? clouds,
    Wind? wind,
    int? visibility,
    double? pop,
    Sys? sys,
    String? dtTxt,
    Rain? rain,
  }) {
    return Forecast(
      dt: dt ?? this.dt,
      main: main ?? this.main,
      weather: weather ?? this.weather,
      clouds: clouds ?? this.clouds,
      wind: wind ?? this.wind,
      visibility: visibility ?? this.visibility,
      pop: pop ?? this.pop,
      sys: sys ?? this.sys,
      dtTxt: dtTxt ?? this.dtTxt,
      rain: rain ?? this.rain,
    );
  }

  @override
  List<Object?> get props {
    return [
      dt,
      main,
      weather,
      clouds,
      wind,
      visibility,
      pop,
      sys,
      dtTxt,
      rain,
    ];
  }
}
