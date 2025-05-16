// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ResourceDataToJson(ResourceData instance) =>
    <String, dynamic>{
      'stringify': instance.stringify,
      'hashCode': instance.hashCode,
      'id': instance.id,
      'custom_data': instance.customData,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'import_meta': instance.importMeta,
      'props': instance.props,
    };

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
