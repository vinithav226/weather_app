import 'package:equatable/equatable.dart';

class Sys extends Equatable {
  const Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json['type'] as int?,
        id: json['id'] as int?,
        country: json['country'] as String?,
        sunrise: json['sunrise'] as int?,
        sunset: json['sunset'] as int?,
      );
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      };

  Sys copyWith({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) {
    return Sys(
      type: type ?? this.type,
      id: id ?? this.id,
      country: country ?? this.country,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  @override
  List<Object?> get props => [type, id, country, sunrise, sunset];
}
