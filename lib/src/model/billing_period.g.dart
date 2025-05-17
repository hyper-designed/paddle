// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingPeriod _$BillingPeriodFromJson(Map<String, dynamic> json) =>
    BillingPeriod(
      startsAt: const DateTimeISO8601Converter().fromJson(
        json['starts_at'] as String,
      ),
      endsAt: const DateTimeISO8601Converter().fromJson(
        json['ends_at'] as String,
      ),
    );

Map<String, dynamic> _$BillingPeriodToJson(BillingPeriod instance) =>
    <String, dynamic>{
      'starts_at': const DateTimeISO8601Converter().toJson(instance.startsAt),
      'ends_at': const DateTimeISO8601Converter().toJson(instance.endsAt),
    };
