// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportMeta _$ImportMetaFromJson(Map<String, dynamic> json) => ImportMeta(
  importedFrom: $enumDecode(_$ImportedFromEnumMap, json['imported_from']),
  externalId: json['external_id'] as String?,
);

Map<String, dynamic> _$ImportMetaToJson(ImportMeta instance) =>
    <String, dynamic>{
      'imported_from': _$ImportedFromEnumMap[instance.importedFrom]!,
      'external_id': instance.externalId,
    };

const _$ImportedFromEnumMap = {ImportedFrom.paddleClassic: 'paddle_classic'};
