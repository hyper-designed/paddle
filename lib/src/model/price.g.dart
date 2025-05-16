// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceList _$PriceListFromJson(Map<String, dynamic> json) => PriceList(
  meta: ResourceMeta.fromJson(json['meta'] as Map<String, dynamic>),
  data:
      (json['data'] as List<dynamic>)
          .map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$PriceListToJson(PriceList instance) => <String, dynamic>{
  'meta': instance.meta,
  'data': instance.data,
};

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
  id: json['id'] as String,
  productId: json['product_id'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$PriceTypeEnumMap, json['type']),
  name: json['name'] as String?,
  billingCycle:
      json['billing_cycle'] == null
          ? null
          : Period.fromJson(json['billing_cycle'] as Map<String, dynamic>),
  trialPeriod:
      json['trial_period'] == null
          ? null
          : Period.fromJson(json['trial_period'] as Map<String, dynamic>),
  taxMode: $enumDecode(_$TaxModeEnumMap, json['tax_mode']),
  unitPrice: UnitPrice.fromJson(json['unit_price'] as Map<String, dynamic>),
  unitPriceOverrides:
      (json['unit_price_overrides'] as List<dynamic>)
          .map((e) => UnitPriceOverride.fromJson(e as Map<String, dynamic>))
          .toList(),
  quantity: Quantity.fromJson(json['quantity'] as Map<String, dynamic>),
  status: $enumDecode(_$EntityStatusEnumMap, json['status']),
  customData: json['custom_data'] as Map<String, dynamic>?,
  importMeta:
      json['import_meta'] == null
          ? null
          : ImportMeta.fromJson(json['import_meta'] as Map<String, dynamic>),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  product:
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
  'id': instance.id,
  'custom_data': instance.customData,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'import_meta': instance.importMeta,
  'product_id': instance.productId,
  'description': instance.description,
  'type': _$PriceTypeEnumMap[instance.type]!,
  'name': instance.name,
  'billing_cycle': instance.billingCycle,
  'trial_period': instance.trialPeriod,
  'tax_mode': _$TaxModeEnumMap[instance.taxMode]!,
  'unit_price': instance.unitPrice,
  'unit_price_overrides': instance.unitPriceOverrides,
  'quantity': instance.quantity,
  'status': _$EntityStatusEnumMap[instance.status]!,
  'product': instance.product,
};

const _$PriceTypeEnumMap = {
  PriceType.custom: 'custom',
  PriceType.standard: 'standard',
};

const _$TaxModeEnumMap = {
  TaxMode.accountSetting: 'account_setting',
  TaxMode.external: 'external',
  TaxMode.internal: 'internal',
};

const _$EntityStatusEnumMap = {
  EntityStatus.archived: 'archived',
  EntityStatus.active: 'active',
};

Quantity _$QuantityFromJson(Map<String, dynamic> json) => Quantity(
  minimum: (json['minimum'] as num).toInt(),
  maximum: (json['maximum'] as num).toInt(),
);

Map<String, dynamic> _$QuantityToJson(Quantity instance) => <String, dynamic>{
  'minimum': instance.minimum,
  'maximum': instance.maximum,
};
