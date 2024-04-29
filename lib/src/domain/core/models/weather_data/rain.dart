import 'package:equatable/equatable.dart';

class Rain extends Equatable {
  const Rain({this.oneH});

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        oneH: (json['1h'] as num?)?.toDouble(),
      );
  final double? oneH;

  Map<String, dynamic> toJson() => {
        '1h': oneH,
      };

  Rain copyWith({
    double? oneH,
  }) {
    return Rain(
      oneH: oneH ?? this.oneH,
    );
  }

  @override
  List<Object?> get props => [oneH];
}
