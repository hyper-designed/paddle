// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page _$PageFromJson(Map<String, dynamic> json) => Page(
  perPage: (json['per_page'] as num).toInt(),
  next: json['next'] as String,
  hasMore: json['has_more'] as bool,
  estimatedTotal: (json['estimated_total'] as num).toInt(),
);

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
  'per_page': instance.perPage,
  'next': instance.next,
  'has_more': instance.hasMore,
  'estimated_total': instance.estimatedTotal,
};
