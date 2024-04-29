import 'package:equatable/equatable.dart';

class Coord extends Equatable {
  const Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: (json['lat'] as num?)?.toDouble(),
        lon: (json['lon'] as num?)?.toDouble(),
      );
  final double? lat;
  final double? lon;

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };

  Coord copyWith({
    double? lat,
    double? lon,
  }) {
    return Coord(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  @override
  List<Object?> get props => [lat, lon];
}
