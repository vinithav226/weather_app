import 'package:equatable/equatable.dart';

class Rain extends Equatable {
  const Rain({this.threeh});

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        threeh: (json['3h'] as num?)?.toDouble(),
      );
  final double? threeh;

  Map<String, dynamic> toJson() => {
        '3h': threeh,
      };

  Rain copyWith({
    double? threeh,
  }) {
    return Rain(
      threeh: threeh ?? this.threeh,
    );
  }

  @override
  List<Object?> get props => [threeh];
}
