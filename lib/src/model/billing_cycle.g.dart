// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_cycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingCycle _$BillingCycleFromJson(Map<String, dynamic> json) => BillingCycle(
  frequency: (json['frequency'] as num).toInt(),
  interval: $enumDecode(_$IntervalEnumMap, json['interval']),
);

Map<String, dynamic> _$BillingCycleToJson(BillingCycle instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'interval': _$IntervalEnumMap[instance.interval]!,
    };

const _$IntervalEnumMap = {
  Interval.day: 'day',
  Interval.week: 'week',
  Interval.month: 'month',
  Interval.year: 'year',
};
