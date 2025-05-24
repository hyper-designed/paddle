import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils.dart';
import 'models.dart';

part 'price.g.dart';

@JsonSerializable()
class PriceList extends ResourceList<Price> {
  PriceList({required super.meta, required super.data});

  factory PriceList.fromJson(Map<String, dynamic> json) =>
      _$PriceListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceListToJson(this);

  @override
  PriceList copyWith({ResourceMeta? meta, List<Price>? data}) =>
      PriceList(meta: meta ?? this.meta, data: data ?? this.data);
}

/// Type of price. Determines how the price is charged.
enum PriceType {
  /// Non-catalog item. Typically created for a specific transaction or
  /// subscription. Not returned when listing or shown in the Paddle dashboard.
  custom,

  /// Standard item. Can be considered part of your catalog and reused across transactions and subscriptions easily.
  standard,
}

/// How tax is calculated for this price.
enum TaxMode {
  /// Prices use the setting from your account.
  @JsonValue('account_setting')
  accountSetting,

  /// Prices are exclusive of tax.
  external,

  /// Prices are inclusive of tax.
  internal,
}

/// Price entities describe what customers pay for products and how often
/// they're billed. They hold charging information.
///
/// Price entities describe what customers pay for products and how often
/// they're billed. They're linked to products using product IDs.
///
/// Price entities hold information like:
///
/// How much it costs.
/// What currency it's billed in.
/// Whether it's one-time or recurring.
/// How often it's billed, if recurring.
/// How long a trial period is, if any.
///
/// You can add as many prices as you like against a product — especially
/// useful for subscription plans. For example, a "premium plan" product might
/// have an annual price and a monthly price.
///
/// For country-specific pricing, use price overrides rather than creating
/// multiple prices. Price overrides let you override your base price with a
/// custom price and currency for any country.
///
/// Add prices to checkouts, transactions, and subscriptions to let customers
/// purchase products.
@JsonSerializable()
final class Price extends ResourceData {
  /// Paddle ID for the product that this price is for.
  @JsonKey(name: 'product_id')
  final String productId;

  /// Internal description for this price, not shown to customers.
  final String description;

  /// Type of price. Determines how the price is charged.
  final PriceType type;

  /// Name of this price, shown to customers at checkout and on invoices.
  final String? name;

  /// How often this price should be charged.
  @JsonKey(name: 'billing_cycle')
  final Period? billingCycle;

  /// Trial period for the product.
  @JsonKey(name: 'trial_period')
  final Period? trialPeriod;

  /// How tax is calculated for this price.
  @JsonKey(name: 'tax_mode')
  final TaxMode taxMode;

  /// Base price. This price applies to all customers, except for customers
  /// located in countries where you have unit_price_overrides.
  @JsonKey(name: 'unit_price')
  final UnitPrice unitPrice;

  /// List of unit price overrides. Use to override the base price with a
  /// custom price and currency for a country or group of countries.
  @JsonKey(name: 'unit_price_overrides')
  final List<UnitPriceOverride> unitPriceOverrides;

  /// Limits on how many times the related product can be purchased at this
  /// price. Useful for discount campaigns.
  final Quantity quantity;

  /// Whether this entity can be used in Paddle.
  final EntityStatus status;

  final Product? product;

  const Price({
    required super.id,
    required this.productId,
    required this.description,
    required this.type,
    this.name,
    this.billingCycle,
    this.trialPeriod,
    required this.taxMode,
    required this.unitPrice,
    required this.unitPriceOverrides,
    required this.quantity,
    required this.status,
    required super.customData,
    super.importMeta,
    required super.createdAt,
    required super.updatedAt,
    this.product,
  });

  @override
  Map<String, dynamic> toJson() => _$PriceToJson(this);

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  @override
  List<Object?> get props => [
    ...super.props,
    productId,
    description,
    type,
    name,
    billingCycle,
    trialPeriod,
    taxMode,
    unitPrice,
    unitPriceOverrides,
    quantity,
    status,
    product,
  ];
}

/// Limits on how many times the related product can be purchased at this price.
/// Useful for discount campaigns.
@JsonSerializable()
final class Quantity with EquatableMixin {
  /// Minimum quantity of the product related to this price that can be bought.
  /// Required if maximum set.
  final int minimum;

  /// Maximum quantity of the product related to this price that can be bought.
  /// Required if minimum set.
  /// Must be greater than or equal to the minimum value.
  final int maximum;

  const Quantity({required this.minimum, required this.maximum});

  factory Quantity.fromJson(Map<String, dynamic> json) =>
      _$QuantityFromJson(json);

  Map<String, dynamic> toJson() => _$QuantityToJson(this);

  @override
  List<Object?> get props => [minimum, maximum];
}
