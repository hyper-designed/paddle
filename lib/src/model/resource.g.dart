// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResourceMeta _$ResourceMetaFromJson(Map<String, dynamic> json) => ResourceMeta(
  requestId: json['request_id'] as String,
  pagination:
      json['pagination'] == null
          ? null
          : Page.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ResourceMetaToJson(ResourceMeta instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'pagination': instance.pagination,
    };
