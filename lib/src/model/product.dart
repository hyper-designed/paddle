import 'package:json_annotation/json_annotation.dart';

import '../../paddle.dart';
import '../utils.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductList extends ResourceList<Product> {
  ProductList({required super.meta, required super.data});

  factory ProductList.fromJson(Map<String, dynamic> json) =>
      _$ProductListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductListToJson(this);

  @override
  ProductList copyWith({ResourceMeta? meta, List<Product>? data}) =>
      ProductList(meta: meta ?? this.meta, data: data ?? this.data);
}

/// Type of item. Standard items are considered part of your catalog and are
/// shown in the Paddle dashboard.
enum ProductType {
  /// Non-catalog item. Typically created for a specific transaction or
  /// subscription. Not returned when listing or shown in the Paddle dashboard.
  custom,

  /// Standard item. Can be considered part of your catalog and reused across
  /// transactions and subscriptions easily.
  standard,
}

/// Tax category for this product. Used for charging the correct rate of tax.
/// Selected tax category must be enabled on your Paddle account.
@JsonEnum(alwaysCreate: true)
enum TaxCategory {
  /// Non-customizable digital files or media (not software) acquired with an
  /// up front payment that can be accessed without any physical product being delivered.
  @JsonValue('digital-goods')
  digitalGoods,

  /// Digital books and educational material which is sold with permanent
  /// rights for use by the customer.
  @JsonValue('ebooks')
  ebooks,

  /// Remote configuration, set-up, and integrating software on behalf of a
  /// customer.
  @JsonValue('implementation-services')
  implementationServices,

  /// Services that involve the application of your expertise and specialized
  /// knowledge of a software product.
  @JsonValue('professional-services')
  professionalServices,

  /// Products that allow users to connect to and use online or cloud-based
  /// applications over the Internet.
  @JsonValue('saas')
  saas,

  /// Services that can be used to customize and white label software products.
  @JsonValue('software-programming-services')
  softwareProgrammingServices,

  /// Software products that are pre-written and can be downloaded and
  /// installed onto a local device.
  @JsonValue('standard')
  standard,

  /// Training and education services related to software products.
  @JsonValue('training-services')
  trainingServices,

  /// Cloud storage service for personal or corporate information, assets,
  /// or intellectual property.
  @JsonValue('website-hosting')
  websiteHosting;

  String get param => switch (this) {
    digitalGoods => 'digital-goods',
    ebooks => 'ebooks',
    implementationServices => 'implementation-services',
    professionalServices => 'professional-services',
    saas => 'saas',
    softwareProgrammingServices => 'software-programming-services',
    standard => 'standard',
    trainingServices => 'training-services',
    websiteHosting => 'website-hosting',
  };
}

@JsonSerializable()
final class Product extends ResourceData {
  /// Name of this product.
  final String name;

  /// Short description for this product.
  final String? description;

  /// Whether this entity can be used in Paddle.
  final EntityStatus status;

  /// Type of item. Standard items are considered part of your catalog and are
  /// shown in the Paddle dashboard.
  final ProductType type;

  /// Tax category for this product. Used for charging the correct rate of tax.
  /// Selected tax category must be enabled on your Paddle account.
  @JsonKey(name: 'tax_category')
  final TaxCategory taxCategory;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  final List<Price>? prices;

  const Product({
    required super.id,
    required this.name,
    this.description,
    required this.status,
    required this.type,
    required this.taxCategory,
    this.imageUrl,
    required super.customData,
    super.importMeta,
    required super.createdAt,
    required super.updatedAt,
    this.prices,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    if (json['data'] case Map<String, dynamic> data) {
      return _$ProductFromJson(data);
    }
    return _$ProductFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [
    ...super.props,
    name,
    description,
    status,
    type,
    taxCategory,
    imageUrl,
    prices,
  ];
}
