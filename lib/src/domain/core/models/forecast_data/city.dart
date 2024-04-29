import 'package:coffee_shop/src/domain/core/models/forecast_data/coord.dart';
import 'package:equatable/equatable.dart';

class City extends Equatable {
  const City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'] as int?,
        name: json['name'] as String?,
        coord: json['coord'] == null
            ? null
            : Coord.fromJson(json['coord'] as Map<String, dynamic>),
        country: json['country'] as String?,
        population: json['population'] as int?,
        timezone: json['timezone'] as int?,
        sunrise: json['sunrise'] as int?,
        sunset: json['sunset'] as int?,
      );
  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final int? population;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'coord': coord?.toJson(),
        'country': country,
        'population': population,
        'timezone': timezone,
        'sunrise': sunrise,
        'sunset': sunset,
      };

  City copyWith({
    int? id,
    String? name,
    Coord? coord,
    String? country,
    int? population,
    int? timezone,
    int? sunrise,
    int? sunset,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      coord: coord ?? this.coord,
      country: country ?? this.country,
      population: population ?? this.population,
      timezone: timezone ?? this.timezone,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      coord,
      country,
      population,
      timezone,
      sunrise,
      sunset,
    ];
  }
}
