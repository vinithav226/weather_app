import 'package:equatable/equatable.dart';

class Wind extends Equatable {
  const Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: (json['speed'] as num?)?.toDouble(),
        deg: json['deg'] as int?,
        gust: (json['gust'] as num?)?.toDouble(),
      );
  final double? speed;
  final int? deg;
  final double? gust;

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
        'gust': gust,
      };

  Wind copyWith({
    double? speed,
    int? deg,
    double? gust,
  }) {
    return Wind(
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
      gust: gust ?? this.gust,
    );
  }

  @override
  List<Object?> get props => [speed, deg, gust];
}
