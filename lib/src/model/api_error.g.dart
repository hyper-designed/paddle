// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaddleError _$PaddleErrorFromJson(Map<String, dynamic> json) => PaddleError(
  type: json['type'] as String,
  code: json['code'] as String,
  detail: json['detail'] as String,
  documentationUrl: json['documentation_url'] as String,
  errors:
      (json['errors'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
);

Map<String, dynamic> _$PaddleErrorToJson(PaddleError instance) =>
    <String, dynamic>{
      'type': instance.type,
      'code': instance.code,
      'detail': instance.detail,
      'documentation_url': instance.documentationUrl,
      'errors': instance.errors,
    };

PaddleApiError _$PaddleApiErrorFromJson(Map<String, dynamic> json) =>
    PaddleApiError(
      errors:
          (json['errors'] as List<dynamic>)
              .map((e) => PaddleError.fromJson(e as Map<String, dynamic>))
              .toList(),
      meta: json['meta'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PaddleApiErrorToJson(PaddleApiError instance) =>
    <String, dynamic>{'errors': instance.errors, 'meta': instance.meta};
