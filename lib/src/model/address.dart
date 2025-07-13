import 'package:json_annotation/json_annotation.dart';

import '../../paddle.dart';
import '../utils.dart';

part 'address.g.dart';

@JsonSerializable()
class AddressList extends ResourceList<Address> {
  AddressList({required super.meta, required super.data});

  factory AddressList.fromJson(Map<String, dynamic> json) =>
      _$AddressListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddressListToJson(this);

  @override
  AddressList copyWith({ResourceMeta? meta, List<Address>? data}) =>
      AddressList(meta: meta ?? this.meta, data: data ?? this.data);
}

/// Address entities hold billing address information for a customer.
/// They're subentities of customers.
///
/// Addresses store components of a customer billing address.
/// They're always created against a customer entity.
///
/// You can create as many addresses as you like against a customer —
/// useful for billing companies with different locations.
///
/// Address entities hold address components like:
///
/// Country.
/// ZIP/postal code.
/// State or region.
/// A short, internal description for this address.
/// Customers, addresses, and businesses work with checkouts, transactions,
/// and subscriptions to let customers purchase products and prices.
///
/// Customers require an address to make a purchase.
/// To make buying as frictionless as possible, Paddle only requires a country
/// except in some regions where a ZIP or postal code is also required.
@JsonSerializable()
final class Address extends ResourceData {
  /// Memorable description for this address.
  final String? description;

  /// First line of this address.
  @JsonKey(name: 'first_line')
  final String? firstLine;

  /// Second line of this address.
  @JsonKey(name: 'second_line')
  final String? secondLine;

  /// City of this address.
  final String? city;

  /// ZIP or postal code of this address. Required for some countries.
  @JsonKey(name: 'postal_code')
  final String? postalCode;

  /// State, county, or region of this address.
  final String? region;

  /// Supported two-letter ISO 3166-1 alpha-2 country code for this address.
  @JsonKey(name: 'country_code')
  final String countryCode;

  /// Whether this entity can be used in Paddle.
  final EntityStatus status;

  const Address({
    required super.id,
    this.description,
    this.firstLine,
    this.secondLine,
    this.city,
    this.postalCode,
    this.region,
    required this.countryCode,
    required this.status,
    required super.customData,
    required super.createdAt,
    required super.updatedAt,
    super.importMeta,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    if (json['data'] case Map<String, dynamic> data) {
      return _$AddressFromJson(data);
    }
    return _$AddressFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object?> get props => [
    ...super.props,
    description,
    firstLine,
    secondLine,
    city,
    postalCode,
    region,
    countryCode,
    status,
  ];
}
