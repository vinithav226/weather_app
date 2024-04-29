import 'package:equatable/equatable.dart';

class Clouds extends Equatable {
  const Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json['all'] as int?,
      );
  final int? all;

  Map<String, dynamic> toJson() => {
        'all': all,
      };

  Clouds copyWith({
    int? all,
  }) {
    return Clouds(
      all: all ?? this.all,
    );
  }

  @override
  List<Object?> get props => [all];
}
