import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../paddle.dart';

part 'billing_cycle.g.dart';

@JsonSerializable()
final class BillingCycle with EquatableMixin {
  /// Amount of time.
  final int frequency;

  /// Unit of time.
  final Interval interval;

  const BillingCycle({required this.frequency, required this.interval});

  factory BillingCycle.fromJson(Map<String, dynamic> json) =>
      _$BillingCycleFromJson(json);

  Map<String, dynamic> toJson() => _$BillingCycleToJson(this);

  @override
  List<Object?> get props => [frequency, interval];
}
