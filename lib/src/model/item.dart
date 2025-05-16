import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../paddle.dart';
import '../utils.dart';

part 'item.g.dart';

/// Status of this subscription item. Set automatically by Paddle.
enum ItemStatus {
  /// This item is active. It is not in trial and Paddle bills for it.
  active,

  /// This item is not active. Set when the related subscription is paused.
  inactive,

  /// This item is in trial. Paddle has not billed for it.
  trialing,
}

@JsonSerializable()
final class Item with EquatableMixin {
  /// Status of this subscription item. Set automatically by Paddle.
  final ItemStatus status;

  /// Quantity of this item on the subscription.
  final int quantity;

  /// Whether this is a recurring item. false if one-time.
  final bool recurring;

  /// RFC 3339 datetime string of when this item was added to this subscription.
  @DateTimeISO8601Converter()
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// RFC 3339 datetime string of when this item was last updated on this
  /// subscription.
  @DateTimeISO8601Converter()
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  /// RFC 3339 datetime string of when this item was last billed.
  @JsonKey(name: 'previously_billed_at')
  @DateTimeISO8601Converter()
  final DateTime? previouslyBilledAt;

  /// Trial dates for this item.
  @JsonKey(name: 'trial_dates')
  final TrialDates? trialDates;

  /// RFC 3339 datetime string of when this item is next scheduled to be billed.
  @JsonKey(name: 'next_billed_at')
  @DateTimeISO8601Converter()
  final DateTime? nextBilledAt;

  /// Related price entity for this item. This reflects the price entity at
  /// the time it was added to the subscription.
  final Price price;

  /// Related product entity for this item. This reflects the product entity
  /// at the time it was added to the subscription.
  final Product product;

  Item({
    required this.status,
    required this.price,
    required this.product,
    required this.quantity,
    required this.recurring,
    required this.createdAt,
    required this.updatedAt,
    required this.previouslyBilledAt,
    required this.nextBilledAt,
    required this.trialDates,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  List<Object?> get props => [
    status,
    price,
    product,
    quantity,
    recurring,
    createdAt,
    updatedAt,
    previouslyBilledAt,
    nextBilledAt,
    trialDates,
  ];
}

/// Trial dates for an item.
@JsonSerializable()
final class TrialDates with EquatableMixin {
  /// RFC 3339 datetime string of when this period ends.
  @JsonKey(name: 'ends_at')
  @DateTimeISO8601Converter()
  final DateTime endsAt;

  /// RFC 3339 datetime string of when this period starts.
  @JsonKey(name: 'starts_at')
  @DateTimeISO8601Converter()
  final DateTime startsAt;

  const TrialDates({required this.endsAt, required this.startsAt});

  factory TrialDates.fromJson(Map<String, dynamic> json) =>
      _$TrialDatesFromJson(json);

  Map<String, dynamic> toJson() => _$TrialDatesToJson(this);

  @override
  List<Object?> get props => [endsAt, startsAt];
}
