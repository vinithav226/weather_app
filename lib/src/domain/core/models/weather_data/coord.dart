import 'package:equatable/equatable.dart';

class Coord extends Equatable {
  const Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: (json['lon'] as num?)?.toDouble(),
        lat: (json['lat'] as num?)?.toDouble(),
      );
  final double? lon;
  final double? lat;

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };

  Coord copyWith({
    double? lon,
    double? lat,
  }) {
    return Coord(
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
    );
  }

  @override
  List<Object?> get props => [lon, lat];
}
