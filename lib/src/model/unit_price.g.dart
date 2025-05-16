// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitPrice _$UnitPriceFromJson(Map<String, dynamic> json) => UnitPrice(
  amount: json['amount'] as String,
  currencyCode: json['currency_code'] as String,
);

Map<String, dynamic> _$UnitPriceToJson(UnitPrice instance) => <String, dynamic>{
  'amount': instance.amount,
  'currency_code': instance.currencyCode,
};

UnitPriceOverride _$UnitPriceOverrideFromJson(Map<String, dynamic> json) =>
    UnitPriceOverride(
      countryCodes:
          (json['country_codes'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      unitPrice: UnitPrice.fromJson(json['unit_price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnitPriceOverrideToJson(UnitPriceOverride instance) =>
    <String, dynamic>{
      'country_codes': instance.countryCodes,
      'unit_price': instance.unitPrice,
    };
