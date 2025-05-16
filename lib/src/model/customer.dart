import 'package:json_annotation/json_annotation.dart';

import '../../paddle.dart';
import 'entity_status.dart';

part 'customer.g.dart';

@JsonSerializable()
class CustomerList extends ResourceList<Customer> {
  CustomerList({required super.meta, required super.data});

  factory CustomerList.fromJson(Map<String, dynamic> json) =>
      _$CustomerListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CustomerListToJson(this);

  @override
  CustomerList copyWith({ResourceMeta? meta, List<Customer>? data}) =>
      CustomerList(meta: meta ?? this.meta, data: data ?? this.data);
}

/// Customer entities hold information about the people and businesses that
/// make purchases.
/// They're related to addresses and businesses.
///
/// Customers are the people and businesses that buy the products listed
/// in your catalog.
///
/// Paddle automatically creates customers for you as part of the checkout,
/// or you can create and manage them using the Paddle dashboard or API.
@JsonSerializable()
final class Customer extends ResourceData {
  /// Full name of this customer. Required when creating transactions where
  /// collection_mode is manual (invoices).
  final String? name;

  /// Email address for this customer.
  final String email;

  /// Whether this customer opted into marketing from you. false unless customers
  /// check the marketing consent box when using Paddle Checkout.
  /// Set automatically by Paddle.
  @JsonKey(name: 'marketing_consent')
  final bool marketingConsent;

  /// Whether this entity can be used in Paddle.
  final EntityStatus status;

  /// Valid IETF BCP 47 short form locale tag. If omitted, defaults to en.
  final String locale;

  const Customer({
    required super.id,
    required this.name,
    required this.email,
    required this.marketingConsent,
    required this.status,
    required super.customData,
    required this.locale,
    required super.createdAt,
    required super.updatedAt,
    super.importMeta,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    if (json['data'] case Map<String, dynamic> data) {
      return _$CustomerFromJson(data);
    }
    return _$CustomerFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  List<Object?> get props => [
    ...super.props,
    name,
    email,
    marketingConsent,
    status,
    locale,
  ];
}
