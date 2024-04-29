import 'package:coffee_shop/src/domain/core/models/weather_data/clouds.dart';
import 'package:coffee_shop/src/domain/core/models/weather_data/coord.dart';
import 'package:coffee_shop/src/domain/core/models/weather_data/main.dart';
import 'package:coffee_shop/src/domain/core/models/weather_data/rain.dart';
import 'package:coffee_shop/src/domain/core/models/weather_data/sys.dart';
import 'package:coffee_shop/src/domain/core/models/weather_data/weather.dart';
import 'package:coffee_shop/src/domain/core/models/weather_data/wind.dart';
import 'package:equatable/equatable.dart';

class WeatherData extends Equatable {
  const WeatherData({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        coord: json['coord'] == null
            ? null
            : Coord.fromJson(json['coord'] as Map<String, dynamic>),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        base: json['base'] as String?,
        main: json['main'] == null
            ? null
            : Main.fromJson(json['main'] as Map<String, dynamic>),
        visibility: json['visibility'] as int?,
        wind: json['wind'] == null
            ? null
            : Wind.fromJson(json['wind'] as Map<String, dynamic>),
        rain: json['rain'] == null
            ? null
            : Rain.fromJson(json['rain'] as Map<String, dynamic>),
        clouds: json['clouds'] == null
            ? null
            : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
        dt: json['dt'] as int?,
        sys: json['sys'] == null
            ? null
            : Sys.fromJson(json['sys'] as Map<String, dynamic>),
        timezone: json['timezone'] as int?,
        id: json['id'] as int?,
        name: json['name'] as String?,
        cod: json['cod'] as int?,
      );
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final Main? main;
  final int? visibility;
  final Wind? wind;
  final Rain? rain;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  Map<String, dynamic> toJson() => {
        'coord': coord?.toJson(),
        'weather': weather?.map((e) => e.toJson()).toList(),
        'base': base,
        'main': main?.toJson(),
        'visibility': visibility,
        'wind': wind?.toJson(),
        'rain': rain?.toJson(),
        'clouds': clouds?.toJson(),
        'dt': dt,
        'sys': sys?.toJson(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod,
      };

  WeatherData copyWith({
    Coord? coord,
    List<Weather>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Rain? rain,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) {
    return WeatherData(
      coord: coord ?? this.coord,
      weather: weather ?? this.weather,
      base: base ?? this.base,
      main: main ?? this.main,
      visibility: visibility ?? this.visibility,
      wind: wind ?? this.wind,
      rain: rain ?? this.rain,
      clouds: clouds ?? this.clouds,
      dt: dt ?? this.dt,
      sys: sys ?? this.sys,
      timezone: timezone ?? this.timezone,
      id: id ?? this.id,
      name: name ?? this.name,
      cod: cod ?? this.cod,
    );
  }

  @override
  List<Object?> get props {
    return [
      coord,
      weather,
      base,
      main,
      visibility,
      wind,
      rain,
      clouds,
      dt,
      sys,
      timezone,
      id,
      name,
      cod,
    ];
  }
}
