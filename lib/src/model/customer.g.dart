// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerList _$CustomerListFromJson(Map<String, dynamic> json) => CustomerList(
  meta: ResourceMeta.fromJson(json['meta'] as Map<String, dynamic>),
  data:
      (json['data'] as List<dynamic>)
          .map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CustomerListToJson(CustomerList instance) =>
    <String, dynamic>{'meta': instance.meta, 'data': instance.data};

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
  id: json['id'] as String,
  name: json['name'] as String?,
  email: json['email'] as String,
  marketingConsent: json['marketing_consent'] as bool,
  status: $enumDecode(_$EntityStatusEnumMap, json['status']),
  customData: json['custom_data'] as Map<String, dynamic>?,
  locale: json['locale'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  importMeta:
      json['import_meta'] == null
          ? null
          : ImportMeta.fromJson(json['import_meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
  'id': instance.id,
  'custom_data': instance.customData,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'import_meta': instance.importMeta,
  'name': instance.name,
  'email': instance.email,
  'marketing_consent': instance.marketingConsent,
  'status': _$EntityStatusEnumMap[instance.status]!,
  'locale': instance.locale,
};

const _$EntityStatusEnumMap = {
  EntityStatus.archived: 'archived',
  EntityStatus.active: 'active',
};
