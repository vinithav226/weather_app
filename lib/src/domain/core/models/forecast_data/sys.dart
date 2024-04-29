import 'package:equatable/equatable.dart';

class Sys extends Equatable {
  const Sys({this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json['pod'] as String?,
      );
  final String? pod;

  Map<String, dynamic> toJson() => {
        'pod': pod,
      };

  Sys copyWith({
    String? pod,
  }) {
    return Sys(
      pod: pod ?? this.pod,
    );
  }

  @override
  List<Object?> get props => [pod];
}
