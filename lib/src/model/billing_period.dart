import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils.dart';

part 'billing_period.g.dart';

/// Current billing period for this subscription. Set automatically by Paddle
/// based on the billing cycle. null for paused and canceled subscriptions.
@JsonSerializable()
final class BillingPeriod with EquatableMixin {
  /// RFC 3339 datetime string of when this period starts.
  @JsonKey(name: 'starts_at')
  @DateTimeISO8601Converter()
  final DateTime startsAt;

  /// RFC 3339 datetime string of when this period ends.
  @JsonKey(name: 'ends_at')
  @DateTimeISO8601Converter()
  final DateTime endsAt;

  const BillingPeriod({required this.startsAt, required this.endsAt});

  factory BillingPeriod.fromJson(Map<String, dynamic> json) =>
      _$BillingPeriodFromJson(json);

  Map<String, dynamic> toJson() => _$BillingPeriodToJson(this);

  @override
  List<Object?> get props => [startsAt, endsAt];
}
