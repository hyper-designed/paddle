// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Period _$PeriodFromJson(Map<String, dynamic> json) => Period(
  frequency: (json['frequency'] as num).toInt(),
  interval: $enumDecode(_$IntervalEnumMap, json['interval']),
);

Map<String, dynamic> _$PeriodToJson(Period instance) => <String, dynamic>{
  'frequency': instance.frequency,
  'interval': _$IntervalEnumMap[instance.interval]!,
};

const _$IntervalEnumMap = {
  Interval.day: 'day',
  Interval.week: 'week',
  Interval.month: 'month',
  Interval.year: 'year',
};
