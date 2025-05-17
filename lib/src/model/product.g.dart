// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductList _$ProductListFromJson(Map<String, dynamic> json) => ProductList(
  meta: ResourceMeta.fromJson(json['meta'] as Map<String, dynamic>),
  data:
      (json['data'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{'meta': instance.meta, 'data': instance.data};

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  status: $enumDecode(_$EntityStatusEnumMap, json['status']),
  type: $enumDecode(_$ProductTypeEnumMap, json['type']),
  taxCategory: $enumDecode(_$TaxCategoryEnumMap, json['tax_category']),
  imageUrl: json['image_url'] as String?,
  customData: json['custom_data'] as Map<String, dynamic>?,
  importMeta:
      json['import_meta'] == null
          ? null
          : ImportMeta.fromJson(json['import_meta'] as Map<String, dynamic>),
  createdAt: const DateTimeISO8601Converter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const DateTimeISO8601Converter().fromJson(
    json['updated_at'] as String,
  ),
  prices:
      (json['prices'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'custom_data': instance.customData,
  'created_at': const DateTimeISO8601Converter().toJson(instance.createdAt),
  'updated_at': const DateTimeISO8601Converter().toJson(instance.updatedAt),
  'import_meta': instance.importMeta,
  'name': instance.name,
  'description': instance.description,
  'status': _$EntityStatusEnumMap[instance.status]!,
  'type': _$ProductTypeEnumMap[instance.type]!,
  'tax_category': _$TaxCategoryEnumMap[instance.taxCategory]!,
  'image_url': instance.imageUrl,
  'prices': instance.prices,
};

const _$EntityStatusEnumMap = {
  EntityStatus.archived: 'archived',
  EntityStatus.active: 'active',
};

const _$ProductTypeEnumMap = {
  ProductType.custom: 'custom',
  ProductType.standard: 'standard',
};

const _$TaxCategoryEnumMap = {
  TaxCategory.digitalGoods: 'digital-goods',
  TaxCategory.ebooks: 'ebooks',
  TaxCategory.implementationServices: 'implementation-services',
  TaxCategory.professionalServices: 'professional-services',
  TaxCategory.saas: 'saas',
  TaxCategory.softwareProgrammingServices: 'software-programming-services',
  TaxCategory.standard: 'standard',
  TaxCategory.trainingServices: 'training-services',
  TaxCategory.websiteHosting: 'website-hosting',
};
