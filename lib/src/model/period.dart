import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../paddle.dart';

part 'period.g.dart';

@JsonSerializable()
final class Period with EquatableMixin {
  /// Amount of time.
  final int frequency;

  /// Unit of time.
  final Interval interval;

  Duration get duration => switch (interval) {
    Interval.day => Duration(days: frequency),
    Interval.week => Duration(days: frequency * 7),
    Interval.month => Duration(days: frequency * 30),
    Interval.year => Duration(days: frequency * 365),
  };

  const Period({required this.frequency, required this.interval});

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodToJson(this);

  @override
  List<Object?> get props => [frequency, interval];
}
