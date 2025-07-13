// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressList _$AddressListFromJson(Map<String, dynamic> json) => AddressList(
  meta: ResourceMeta.fromJson(json['meta'] as Map<String, dynamic>),
  data:
      (json['data'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AddressListToJson(AddressList instance) =>
    <String, dynamic>{'meta': instance.meta, 'data': instance.data};

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  id: json['id'] as String,
  description: json['description'] as String?,
  firstLine: json['first_line'] as String?,
  secondLine: json['second_line'] as String?,
  city: json['city'] as String?,
  postalCode: json['postal_code'] as String?,
  region: json['region'] as String?,
  countryCode: json['country_code'] as String,
  status: $enumDecode(_$EntityStatusEnumMap, json['status']),
  customData: json['custom_data'] as Map<String, dynamic>?,
  createdAt: const DateTimeISO8601Converter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const DateTimeISO8601Converter().fromJson(
    json['updated_at'] as String,
  ),
  importMeta:
      json['import_meta'] == null
          ? null
          : ImportMeta.fromJson(json['import_meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'id': instance.id,
  'custom_data': instance.customData,
  'created_at': const DateTimeISO8601Converter().toJson(instance.createdAt),
  'updated_at': const DateTimeISO8601Converter().toJson(instance.updatedAt),
  'import_meta': instance.importMeta,
  'description': instance.description,
  'first_line': instance.firstLine,
  'second_line': instance.secondLine,
  'city': instance.city,
  'postal_code': instance.postalCode,
  'region': instance.region,
  'country_code': instance.countryCode,
  'status': _$EntityStatusEnumMap[instance.status]!,
};

const _$EntityStatusEnumMap = {
  EntityStatus.archived: 'archived',
  EntityStatus.active: 'active',
};
