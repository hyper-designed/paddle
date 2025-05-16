// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  status: $enumDecode(_$ItemStatusEnumMap, json['status']),
  price: Price.fromJson(json['price'] as Map<String, dynamic>),
  product: Product.fromJson(json['product'] as Map<String, dynamic>),
  quantity: (json['quantity'] as num).toInt(),
  recurring: json['recurring'] as bool,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  previouslyBilledAt: _$JsonConverterFromJson<String, DateTime>(
    json['previously_billed_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
  nextBilledAt: _$JsonConverterFromJson<String, DateTime>(
    json['next_billed_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
  trialDates:
      json['trial_dates'] == null
          ? null
          : TrialDates.fromJson(json['trial_dates'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'status': _$ItemStatusEnumMap[instance.status]!,
  'quantity': instance.quantity,
  'recurring': instance.recurring,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'previously_billed_at': _$JsonConverterToJson<String, DateTime>(
    instance.previouslyBilledAt,
    const DateTimeISO8601Converter().toJson,
  ),
  'trial_dates': instance.trialDates,
  'next_billed_at': _$JsonConverterToJson<String, DateTime>(
    instance.nextBilledAt,
    const DateTimeISO8601Converter().toJson,
  ),
  'price': instance.price,
  'product': instance.product,
};

const _$ItemStatusEnumMap = {
  ItemStatus.active: 'active',
  ItemStatus.inactive: 'inactive',
  ItemStatus.trialing: 'trialing',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

TrialDates _$TrialDatesFromJson(Map<String, dynamic> json) => TrialDates(
  endsAt: const DateTimeISO8601Converter().fromJson(json['ends_at'] as String),
  startsAt: const DateTimeISO8601Converter().fromJson(
    json['starts_at'] as String,
  ),
);

Map<String, dynamic> _$TrialDatesToJson(TrialDates instance) =>
    <String, dynamic>{
      'ends_at': const DateTimeISO8601Converter().toJson(instance.endsAt),
      'starts_at': const DateTimeISO8601Converter().toJson(instance.startsAt),
    };
