import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_price.g.dart';

/// Base price. This price applies to all customers, except for customers
/// located in countries where you have unit_price_overrides.
@JsonSerializable()
class UnitPrice with EquatableMixin {
  /// Amount in the lowest denomination for the currency,
  /// e.g. 10 USD = 1000 (cents).
  /// Although represented as a string, this value must be a valid integer.
  final String amount;

  /// Supported three-letter ISO 4217 currency code.
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  UnitPrice({required this.amount, required this.currencyCode});

  factory UnitPrice.fromJson(Map<String, dynamic> json) =>
      _$UnitPriceFromJson(json);

  Map<String, dynamic> toJson() {
    final json = _$UnitPriceToJson(this);
    // Convert amount from string to integer for API compatibility
    json['amount'] = int.parse(amount);
    return json;
  }

  @override
  List<Object?> get props => [amount, currencyCode];
}

/// Unit price overrides for specific countries
@JsonSerializable()
class UnitPriceOverride with EquatableMixin {
  /// Supported two-letter ISO 3166-1 alpha-2 country code.
  /// Customers located in the listed countries are charged the override price.
  @JsonKey(name: 'country_codes')
  final List<String> countryCodes;

  /// Override price. This price applies to customers located in the countries
  /// for this unit price override.
  @JsonKey(name: 'unit_price')
  final UnitPrice unitPrice;

  UnitPriceOverride({required this.countryCodes, required this.unitPrice});

  factory UnitPriceOverride.fromJson(Map<String, dynamic> json) =>
      _$UnitPriceOverrideFromJson(json);

  Map<String, dynamic> toJson() => _$UnitPriceOverrideToJson(this);

  @override
  List<Object?> get props => [countryCodes, unitPrice];
}
