// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionList _$TransactionListFromJson(Map<String, dynamic> json) =>
    TransactionList(
      meta: ResourceMeta.fromJson(json['meta'] as Map<String, dynamic>),
      data:
          (json['data'] as List<dynamic>)
              .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$TransactionListToJson(TransactionList instance) =>
    <String, dynamic>{'meta': instance.meta, 'data': instance.data};

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: json['id'] as String,
  customData: json['custom_data'] as Map<String, dynamic>?,
  createdAt: const DateTimeISO8601Converter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const DateTimeISO8601Converter().fromJson(
    json['updated_at'] as String,
  ),
  status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
  customerId: json['customer_id'] as String?,
  addressId: json['address_id'] as String?,
  businessId: json['business_id'] as String?,
  currencyCode: json['currency_code'] as String,
  origin: $enumDecode(_$TransactionOriginEnumMap, json['origin']),
  subscriptionId: json['subscription_id'] as String?,
  invoiceNumber: json['invoice_number'] as String?,
  collectionMode: $enumDecode(_$CollectionModeEnumMap, json['collection_mode']),
  discountId: json['discount_id'] as String?,
  billingDetails:
      json['billing_details'] == null
          ? null
          : BillingDetails.fromJson(
            json['billing_details'] as Map<String, dynamic>,
          ),
  items:
      (json['items'] as List<dynamic>)
          .map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  details: TransactionDetails.fromJson(json['details'] as Map<String, dynamic>),
  payments:
      (json['payments'] as List<dynamic>)
          .map((e) => PaymentAttempt.fromJson(e as Map<String, dynamic>))
          .toList(),
  checkout:
      json['checkout'] == null
          ? null
          : Checkout.fromJson(json['checkout'] as Map<String, dynamic>),
  billedAt: _$JsonConverterFromJson<String, DateTime>(
    json['billed_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
  revisedAt: _$JsonConverterFromJson<String, DateTime>(
    json['revised_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
  importMeta:
      json['import_meta'] == null
          ? null
          : ImportMeta.fromJson(json['import_meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'custom_data': instance.customData,
      'created_at': const DateTimeISO8601Converter().toJson(instance.createdAt),
      'updated_at': const DateTimeISO8601Converter().toJson(instance.updatedAt),
      'import_meta': instance.importMeta,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'customer_id': instance.customerId,
      'address_id': instance.addressId,
      'business_id': instance.businessId,
      'currency_code': instance.currencyCode,
      'origin': _$TransactionOriginEnumMap[instance.origin]!,
      'subscription_id': instance.subscriptionId,
      'invoice_number': instance.invoiceNumber,
      'collection_mode': _$CollectionModeEnumMap[instance.collectionMode]!,
      'discount_id': instance.discountId,
      'billing_details': instance.billingDetails,
      'items': instance.items,
      'details': instance.details,
      'payments': instance.payments,
      'checkout': instance.checkout,
      'billed_at': _$JsonConverterToJson<String, DateTime>(
        instance.billedAt,
        const DateTimeISO8601Converter().toJson,
      ),
      'revised_at': _$JsonConverterToJson<String, DateTime>(
        instance.revisedAt,
        const DateTimeISO8601Converter().toJson,
      ),
    };

const _$TransactionStatusEnumMap = {
  TransactionStatus.draft: 'draft',
  TransactionStatus.ready: 'ready',
  TransactionStatus.billed: 'billed',
  TransactionStatus.paid: 'paid',
  TransactionStatus.completed: 'completed',
  TransactionStatus.canceled: 'canceled',
  TransactionStatus.pastDue: 'pastDue',
};

const _$TransactionOriginEnumMap = {
  TransactionOrigin.api: 'api',
  TransactionOrigin.subscriptionCharge: 'subscription_charge',
  TransactionOrigin.subscriptionPaymentMethodChange:
      'subscription_payment_method_change',
  TransactionOrigin.subscriptionRecurring: 'subscription_recurring',
  TransactionOrigin.subscriptionUpdate: 'subscription_update',
  TransactionOrigin.web: 'web',
};

const _$CollectionModeEnumMap = {
  CollectionMode.automatic: 'automatic',
  CollectionMode.manual: 'manual',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

TransactionItem _$TransactionItemFromJson(Map<String, dynamic> json) =>
    TransactionItem(
      priceId: json['price_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionItemToJson(TransactionItem instance) =>
    <String, dynamic>{
      'price_id': instance.priceId,
      'quantity': instance.quantity,
      'price': instance.price,
    };

Proration _$ProrationFromJson(Map<String, dynamic> json) => Proration(
  rate: json['rate'] as String,
  billingPeriod: BillingPeriod.fromJson(
    json['billing_period'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ProrationToJson(Proration instance) => <String, dynamic>{
  'rate': instance.rate,
  'billing_period': instance.billingPeriod,
};

BaseTotals _$BaseTotalsFromJson(Map<String, dynamic> json) => BaseTotals(
  subtotal: json['subtotal'] as String,
  tax: json['tax'] as String,
  total: json['total'] as String,
);

Map<String, dynamic> _$BaseTotalsToJson(BaseTotals instance) =>
    <String, dynamic>{
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'total': instance.total,
    };

TransactionDetails _$TransactionDetailsFromJson(Map<String, dynamic> json) =>
    TransactionDetails(
      taxRatesUsed:
          (json['tax_rates_used'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      totals: TransactionTotals.fromJson(
        json['totals'] as Map<String, dynamic>,
      ),
      currencyCode: json['currency_code'] as String,
      adjustedTotals: AdjustedTotals.fromJson(
        json['adjusted_totals'] as Map<String, dynamic>,
      ),
      payoutTotals:
          json['payout_totals'] == null
              ? null
              : PayoutTotals.fromJson(
                json['payout_totals'] as Map<String, dynamic>,
              ),
      adjustedPayoutTotals:
          json['adjusted_payout_totals'] == null
              ? null
              : AdjustedPayoutTotals.fromJson(
                json['adjusted_payout_totals'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$TransactionDetailsToJson(TransactionDetails instance) =>
    <String, dynamic>{
      'tax_rates_used': instance.taxRatesUsed,
      'totals': instance.totals,
      'currency_code': instance.currencyCode,
      'adjusted_totals': instance.adjustedTotals,
      'payout_totals': instance.payoutTotals,
      'adjusted_payout_totals': instance.adjustedPayoutTotals,
    };

TransactionTotals _$TransactionTotalsFromJson(Map<String, dynamic> json) =>
    TransactionTotals(
      subtotal: json['subtotal'] as String,
      tax: json['tax'] as String,
      total: json['total'] as String,
      discount: json['discount'] as String,
      credit: json['credit'] as String,
      creditToBalance: json['credit_to_balance'] as String,
      balance: json['balance'] as String,
      grandTotal: json['grand_total'] as String,
      fee: json['fee'] as String?,
      earnings: json['earnings'] as String?,
    );

Map<String, dynamic> _$TransactionTotalsToJson(TransactionTotals instance) =>
    <String, dynamic>{
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'total': instance.total,
      'fee': instance.fee,
      'earnings': instance.earnings,
      'discount': instance.discount,
      'credit': instance.credit,
      'credit_to_balance': instance.creditToBalance,
      'balance': instance.balance,
      'grand_total': instance.grandTotal,
    };

AdjustedTotals _$AdjustedTotalsFromJson(Map<String, dynamic> json) =>
    AdjustedTotals(
      subtotal: json['subtotal'] as String,
      tax: json['tax'] as String,
      total: json['total'] as String,
      grandTotal: json['grand_total'] as String,
      fee: json['fee'] as String?,
      earnings: json['earnings'] as String?,
      currencyCode: json['currency_code'] as String,
    );

Map<String, dynamic> _$AdjustedTotalsToJson(AdjustedTotals instance) =>
    <String, dynamic>{
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'total': instance.total,
      'fee': instance.fee,
      'earnings': instance.earnings,
      'grand_total': instance.grandTotal,
      'currency_code': instance.currencyCode,
    };

PayoutTotals _$PayoutTotalsFromJson(Map<String, dynamic> json) => PayoutTotals(
  subtotal: json['subtotal'] as String,
  tax: json['tax'] as String,
  total: json['total'] as String,
  discount: json['discount'] as String,
  credit: json['credit'] as String,
  creditToBalance: json['credit_to_balance'] as String,
  balance: json['balance'] as String,
  grandTotal: json['grand_total'] as String,
  fee: json['fee'] as String,
  earnings: json['earnings'] as String,
  currencyCode: json['currency_code'] as String,
);

Map<String, dynamic> _$PayoutTotalsToJson(PayoutTotals instance) =>
    <String, dynamic>{
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'total': instance.total,
      'discount': instance.discount,
      'credit': instance.credit,
      'credit_to_balance': instance.creditToBalance,
      'balance': instance.balance,
      'grand_total': instance.grandTotal,
      'fee': instance.fee,
      'earnings': instance.earnings,
      'currency_code': instance.currencyCode,
    };

AdjustedPayoutTotals _$AdjustedPayoutTotalsFromJson(
  Map<String, dynamic> json,
) => AdjustedPayoutTotals(
  subtotal: json['subtotal'] as String,
  tax: json['tax'] as String,
  total: json['total'] as String,
  fee: json['fee'] as String,
  chargebackFee: ChargebackFee.fromJson(
    json['chargeback_fee'] as Map<String, dynamic>,
  ),
  earnings: json['earnings'] as String,
  currencyCode: json['currency_code'] as String,
);

Map<String, dynamic> _$AdjustedPayoutTotalsToJson(
  AdjustedPayoutTotals instance,
) => <String, dynamic>{
  'subtotal': instance.subtotal,
  'tax': instance.tax,
  'total': instance.total,
  'fee': instance.fee,
  'chargeback_fee': instance.chargebackFee,
  'earnings': instance.earnings,
  'currency_code': instance.currencyCode,
};

ChargebackFee _$ChargebackFeeFromJson(Map<String, dynamic> json) =>
    ChargebackFee(
      amount: json['amount'] as String,
      original:
          json['original'] == null
              ? null
              : OriginalChargebackFee.fromJson(
                json['original'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$ChargebackFeeToJson(ChargebackFee instance) =>
    <String, dynamic>{'amount': instance.amount, 'original': instance.original};

OriginalChargebackFee _$OriginalChargebackFeeFromJson(
  Map<String, dynamic> json,
) => OriginalChargebackFee(
  amount: json['amount'] as String,
  currencyCode: json['currency_code'] as String,
);

Map<String, dynamic> _$OriginalChargebackFeeToJson(
  OriginalChargebackFee instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'currency_code': instance.currencyCode,
};

Checkout _$CheckoutFromJson(Map<String, dynamic> json) =>
    Checkout(url: json['url'] as String?);

Map<String, dynamic> _$CheckoutToJson(Checkout instance) => <String, dynamic>{
  'url': instance.url,
};
