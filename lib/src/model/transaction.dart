import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../paddle.dart';
import '../utils.dart';

part 'transaction.g.dart';

@JsonSerializable()
class TransactionList extends ResourceList<Transaction> {
  TransactionList({required super.meta, required super.data});

  factory TransactionList.fromJson(Map<String, dynamic> json) =>
      _$TransactionListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransactionListToJson(this);

  @override
  TransactionList copyWith({ResourceMeta? meta, List<Transaction>? data}) =>
      TransactionList(meta: meta ?? this.meta, data: data ?? this.data);
}

/// Status of this transaction. You may set a transaction to billed or
/// canceled, other statuses are set automatically by Paddle.
/// Automatically-collected transactions may return completed if payment
/// is captured successfully, or past_due if payment failed.
enum TransactionStatus {
  /// Transaction is missing required fields. Typically the first stage of a
  /// checkout before customer details are captured.
  draft,

  /// Transaction has all of the required fields to be marked as billed or
  /// completed.
  ready,

  /// Transaction has been updated to billed. Billed transactions get an
  /// invoice number and are considered a legal record.
  /// They cannot be changed. Typically used as part of an invoice workflow.
  billed,

  /// Transaction is fully paid, but has not yet been processed internally.
  paid,

  /// Transaction is fully paid and processed.
  completed,

  /// Transaction has been updated to canceled. If an invoice, it's no longer
  /// due.
  canceled,

  /// Transaction is past due. Occurs for automatically-collected transactions
  /// when the related subscription is in dunning, and for manually-collected
  /// transactions when payment terms have elapsed.
  pastDue,
}

/// Describes how this transaction was created.
enum TransactionOrigin {
  /// Transaction created via the Paddle API.
  api,

  /// Transaction created automatically by Paddle as a result of a one-time
  /// charge for a subscription.
  @JsonValue('subscription_charge')
  subscriptionCharge,

  /// Transaction created automatically as part of updating a payment method.
  /// May be a zero value transaction.
  @JsonValue('subscription_payment_method_change')
  subscriptionPaymentMethodChange,

  /// Transaction created automatically by Paddle as a result of a
  /// subscription renewal.
  @JsonValue('subscription_recurring')
  subscriptionRecurring,

  /// Transaction created automatically by Paddle as a result of an update
  /// to a subscription.
  @JsonValue('subscription_update')
  subscriptionUpdate,

  /// Transaction created automatically by Paddle.js for a checkout.
  web,
}

/// Transaction entities calculate and capture revenue.
/// They hold information about a customer purchase.
///
/// Transactions are at the heart of Paddle. They tie together products, prices,
/// and discounts with customers to calculate revenue for checkouts, invoices,
/// and subscriptions.
///
/// Paddle automatically creates transactions when customers sign up using the
/// checkout, as well as when subscription lifecycle events like renewals
/// or upgrades happen.
///
/// You can also create a transaction through the Paddle dashboard or the API.
/// You can collect for a transaction manually to create an invoice, or collect
/// automatically using a card on file or by presenting a checkout.
///
/// Transactions hold information like:
///
/// Who the customer is.
/// Which items they're purchasing.
/// Calculated totals for the customer and items.
/// Any payment attempts.
///
/// Details
/// Transactions handle all parts of revenue calculation, including complex
/// proration operations, localized pricing, and tax calculations.
///
/// Paddle returns calculated totals for a transaction in the details object.
/// Details are the single source for totals on a transaction.
/// They're used for collecting payment from a customer and revenue recognition.
///
/// Payments
/// Though the terms "transaction" and "payment" are sometimes used
/// interchangeably, they're distinct entities in Paddle:
///
/// Transactions calculate and captures revenue, ready for payment
/// Payments are attempts to collect for the amount against a
/// transaction — both online and offline
/// Transactions can have more than one payment against them.
/// For example, customers paying for larger value deals by invoice might make
/// multiple payments, and automatically collected payments might fail.
///
/// Previews
/// For pricing pages and other screens that let customers preview changes to
/// their subscription, you can preview a transaction rather than creating it.
///
/// When previewing a transaction, you don't need to send the same
/// information as you would if you were creating it.
///
/// Transactions are financial records. They can't be deleted, and they can't be
/// changed once they've been billed. Cancel a transaction, or create an
/// adjustment to record post-billing actions that impact a transaction.
@JsonSerializable()
final class Transaction extends ResourceData {
  /// Status of this transaction. You may set a transaction to billed or
  /// canceled, other statuses are set automatically by Paddle.
  /// Automatically-collected transactions may return completed if payment
  /// is captured successfully, or past_due if payment failed.
  final TransactionStatus status;

  /// Paddle ID of the customer that this transaction is for,
  /// prefixed with ctm_.
  @JsonKey(name: 'customer_id')
  final String? customerId;

  /// Paddle ID of the address that this transaction is for,
  /// prefixed with add_.
  @JsonKey(name: 'address_id')
  final String? addressId;

  /// Paddle ID of the business that this transaction is for,
  /// prefixed with biz_.
  @JsonKey(name: 'business_id')
  final String? businessId;

  /// Supported three-letter ISO 4217 currency code. Must be USD, EUR, or
  /// GBP if collection_mode is manual.
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// Describes how this transaction was created.
  final TransactionOrigin origin;

  /// Paddle ID of the subscription that this transaction is for,
  /// prefixed with sub_.
  @JsonKey(name: 'subscription_id')
  final String? subscriptionId;

  /// Invoice number for this transaction. Automatically generated by Paddle
  /// when you mark a transaction as billed where collection_mode is manual.
  @JsonKey(name: 'invoice_number')
  final String? invoiceNumber;

  /// How payment is collected for this transaction. automatic for checkout,
  /// manual for invoices.
  @JsonKey(name: 'collection_mode')
  final CollectionMode collectionMode;

  /// Paddle ID of the discount applied to this transaction, prefixed with dsc_.
  @JsonKey(name: 'discount_id')
  final String? discountId;

  /// Details for invoicing. Required if collection_mode is manual.
  @JsonKey(name: 'billing_details')
  final BillingDetails? billingDetails;

  /// List of items on this transaction. For calculated totals, use
  /// details.line_items.
  final List<TransactionItem> items;

  /// Calculated totals for a transaction, including proration, discounts, tax,
  /// and currency conversion.
  /// Considered the source of truth for totals on a transaction.
  final TransactionDetails details;

  /// List of payment attempts for this transaction, including successful
  /// payments.
  /// Sorted by created_at in descending order, so most recent attempts are
  /// returned first.
  final List<PaymentAttempt> payments;

  /// Paddle Checkout details for this transaction. Returned for
  /// automatically-collected transactions and where billing_details.enable_checkout
  /// is true for manually-collected transactions; null otherwise.
  final Checkout? checkout;

  /// RFC 3339 datetime string of when this transaction was marked as billed.
  /// null for transactions that aren't billed or completed.
  /// Set automatically by Paddle.
  @JsonKey(name: 'billed_at')
  @DateTimeISO8601Converter()
  final DateTime? billedAt;

  /// RFC 3339 datetime string of when a transaction was revised.
  /// Revisions describe an update to customer information for a billed or
  /// completed transaction. null if not revised.
  /// Set automatically by Paddle.
  @JsonKey(name: 'revised_at')
  @DateTimeISO8601Converter()
  final DateTime? revisedAt;

  Transaction({
    required super.id,
    required super.customData,
    required super.createdAt,
    required super.updatedAt,
    required this.status,
    this.customerId,
    this.addressId,
    this.businessId,
    required this.currencyCode,
    required this.origin,
    this.subscriptionId,
    this.invoiceNumber,
    required this.collectionMode,
    this.discountId,
    this.billingDetails,
    required this.items,
    required this.details,
    required this.payments,
    this.checkout,
    this.billedAt,
    this.revisedAt,
    super.importMeta,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    if (json['data'] case Map<String, dynamic> data) {
      return _$TransactionFromJson(data);
    }
    return _$TransactionFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  List<Object?> get props => [
    ...super.props,
    status,
    customerId,
    addressId,
    businessId,
    currencyCode,
    origin,
    subscriptionId,
    invoiceNumber,
    collectionMode,
    discountId,
    billingDetails,
    items,
    details,
    payments,
    checkout,
  ];
}

@JsonSerializable()
final class TransactionItem with EquatableMixin {
  /// Paddle ID for the price to add to this transaction, prefixed with pri_.
  @JsonKey(name: 'price_id')
  final String priceId;

  /// Quantity of this item on the transaction.
  final int quantity;

  /// Represents a price entity.
  final Price price;

  const TransactionItem({
    required this.priceId,
    required this.quantity,
    required this.price,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionItemToJson(this);

  @override
  List<Object?> get props => [priceId, quantity, price];
}

/// How proration was calculated for this item.
///
/// Populated when a transaction is created from a subscription change,
/// where proration_billing_mode was prorated_immediately or
/// prorated_next_billing_period. Set automatically by Paddle.
@JsonSerializable()
final class Proration with EquatableMixin {
  /// Rate used to calculate proration.
  final String rate;

  /// Billing period that proration is based on.
  @JsonKey(name: 'billing_period')
  final BillingPeriod billingPeriod;

  const Proration({required this.rate, required this.billingPeriod});

  factory Proration.fromJson(Map<String, dynamic> json) =>
      _$ProrationFromJson(json);

  Map<String, dynamic> toJson() => _$ProrationToJson(this);

  @override
  List<Object?> get props => [rate, billingPeriod];
}

/// Base class for all transaction total objects
@JsonSerializable()
class BaseTotals with EquatableMixin {
  /// Subtotal before discount, tax, and deductions.
  /// If an item, unit price multiplied by quantity.
  final String subtotal;

  /// Total tax on the subtotal.
  final String tax;

  /// Total after tax.
  final String total;

  const BaseTotals({
    required this.subtotal,
    required this.tax,
    required this.total,
  });

  @override
  List<Object?> get props => [subtotal, tax, total];
}

/// Mixin for totals that include currency code
mixin CurrencyCodeMixin {
  /// Three-letter ISO 4217 currency code of the currency used
  /// for this transaction.
  @JsonKey(name: 'currency_code')
  String get currencyCode;
}

/// Mixin for totals that include fee and earnings
mixin FeesAndEarningsMixin {
  /// Total fee taken by Paddle for this transaction.
  String? get fee;

  /// Total earnings for this transaction.
  String? get earnings;
}

/// Calculated totals for a transaction, including proration, discounts, tax,
/// and currency conversion. Considered the source of truth for totals on
/// a transaction.
@JsonSerializable()
final class TransactionDetails with EquatableMixin {
  /// List of tax rates applied for this transaction.
  @JsonKey(name: 'tax_rates_used')
  final List<String> taxRatesUsed;

  /// Calculated totals for the transaction, including subtotal, discount, tax,
  /// and total amounts.
  final TransactionTotals totals;

  /// Three-letter ISO 4217 currency code of the currency used
  /// for this transaction.
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// Breakdown of the totals for a transaction after adjustments.
  @JsonKey(name: 'adjusted_totals')
  final AdjustedTotals adjustedTotals;

  /// Breakdown of the payout total for a transaction.
  /// null until the transaction is completed.
  /// Returned in your payout currency.
  @JsonKey(name: 'payout_totals')
  final PayoutTotals? payoutTotals;

  /// Breakdown of the payout total for a transaction after adjustments.
  /// null until the transaction is completed.
  @JsonKey(name: 'adjusted_payout_totals')
  final AdjustedPayoutTotals? adjustedPayoutTotals;

  // TODO: List of line items on this transaction. `line_items`

  const TransactionDetails({
    required this.taxRatesUsed,
    required this.totals,
    required this.currencyCode,
    required this.adjustedTotals,
    required this.payoutTotals,
    required this.adjustedPayoutTotals,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailsToJson(this);

  @override
  List<Object?> get props => [
    taxRatesUsed,
    totals,
    currencyCode,
    adjustedTotals,
    payoutTotals,
    adjustedPayoutTotals,
  ];
}

/// Totals for a transaction including subtotal, discount, tax, and total.
@JsonSerializable()
final class TransactionTotals extends BaseTotals with FeesAndEarningsMixin {
  @override
  final String? fee;

  @override
  final String? earnings;

  /// Total discount as a result of any discounts applied.
  ///
  /// Except for percentage discounts, Paddle applies tax to discounts
  /// based on the line item price.tax_mode. If price.tax_mode for a
  /// line item is internal, Paddle removes tax from the discount applied.
  final String discount;

  /// Total credit applied to this transaction. This includes credits
  /// applied using a customer's credit balance and adjustments
  /// to a billed transaction.
  final String credit;

  /// Additional credit generated from negative details.line_items.
  /// This credit is added to the customer balance.
  @JsonKey(name: 'credit_to_balance')
  final String creditToBalance;

  /// Total due on a transaction after credits and any payments.
  final String balance;

  /// Total due on a transaction after credits but before any payments.
  @JsonKey(name: 'grand_total')
  final String grandTotal;

  const TransactionTotals({
    required super.subtotal,
    required super.tax,
    required super.total,
    required this.discount,
    required this.credit,
    required this.creditToBalance,
    required this.balance,
    required this.grandTotal,
    this.fee,
    this.earnings,
  });

  factory TransactionTotals.fromJson(Map<String, dynamic> json) =>
      _$TransactionTotalsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionTotalsToJson(this);

  @override
  List<Object?> get props => [
    ...super.props,
    discount,
    credit,
    creditToBalance,
    balance,
    grandTotal,
    fee,
    earnings,
  ];
}

/// Breakdown of the totals for a transaction after adjustments.
@JsonSerializable()
final class AdjustedTotals extends BaseTotals
    with FeesAndEarningsMixin, CurrencyCodeMixin {
  @override
  final String? fee;

  @override
  final String? earnings;

  /// Total due after credits but before any payments.
  @JsonKey(name: 'grand_total')
  final String grandTotal;

  @override
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  const AdjustedTotals({
    required super.subtotal,
    required super.tax,
    required super.total,
    required this.grandTotal,
    this.fee,
    this.earnings,
    required this.currencyCode,
  });

  factory AdjustedTotals.fromJson(Map<String, dynamic> json) =>
      _$AdjustedTotalsFromJson(json);

  Map<String, dynamic> toJson() => _$AdjustedTotalsToJson(this);

  @override
  List<Object?> get props => [
    ...super.props,
    grandTotal,
    fee,
    earnings,
    currencyCode,
  ];
}

/// Breakdown of the payout total for a transaction.
/// null until the transaction is completed.
/// Returned in your payout currency.
@JsonSerializable()
final class PayoutTotals extends BaseTotals with CurrencyCodeMixin {
  /// Total discount as a result of any discounts applied.
  ///
  /// Except for percentage discounts, Paddle applies tax to discounts
  /// based on the line item price.tax_mode. If price.tax_mode for a
  /// line item is internal, Paddle removes tax from the discount applied.
  final String discount;

  /// Total credit applied to this transaction. This includes credits
  /// applied using a customer's credit balance and adjustments
  /// to a billed transaction.
  final String credit;

  /// Additional credit generated from negative details.line_items.
  /// This credit is added to the customer balance.
  @JsonKey(name: 'credit_to_balance')
  final String creditToBalance;

  /// Total due on a transaction after credits and any payments.
  final String balance;

  /// Total due on a transaction after credits but before any payments.
  @JsonKey(name: 'grand_total')
  final String grandTotal;

  /// Total fee taken by Paddle for this payout.
  final String fee;

  /// Total earnings for this payout. This is the subtotal minus the Paddle fee.
  final String earnings;

  @override
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  const PayoutTotals({
    required super.subtotal,
    required super.tax,
    required super.total,
    required this.discount,
    required this.credit,
    required this.creditToBalance,
    required this.balance,
    required this.grandTotal,
    required this.fee,
    required this.earnings,
    required this.currencyCode,
  });

  factory PayoutTotals.fromJson(Map<String, dynamic> json) =>
      _$PayoutTotalsFromJson(json);

  Map<String, dynamic> toJson() => _$PayoutTotalsToJson(this);

  @override
  List<Object?> get props => [
    ...super.props,
    discount,
    credit,
    creditToBalance,
    balance,
    grandTotal,
    fee,
    earnings,
    currencyCode,
  ];
}

/// Breakdown of the payout total for a transaction after adjustments.
/// null until the transaction is completed.
@JsonSerializable()
final class AdjustedPayoutTotals extends BaseTotals with CurrencyCodeMixin {
  /// Total fee taken by Paddle for this payout.
  final String fee;

  /// Details of any chargeback fees incurred for this transaction.
  @JsonKey(name: 'chargeback_fee')
  final ChargebackFee chargebackFee;

  /// Total earnings for this payout. This is the subtotal minus
  /// the Paddle fee, excluding chargeback fees.
  final String earnings;

  @override
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  const AdjustedPayoutTotals({
    required super.subtotal,
    required super.tax,
    required super.total,
    required this.fee,
    required this.chargebackFee,
    required this.earnings,
    required this.currencyCode,
  });

  factory AdjustedPayoutTotals.fromJson(Map<String, dynamic> json) =>
      _$AdjustedPayoutTotalsFromJson(json);

  Map<String, dynamic> toJson() => _$AdjustedPayoutTotalsToJson(this);

  @override
  List<Object?> get props => [
    ...super.props,
    fee,
    chargebackFee,
    earnings,
    currencyCode,
  ];
}

/// Details of any chargeback fees incurred for a transaction.
@JsonSerializable()
final class ChargebackFee with EquatableMixin {
  /// Chargeback fee converted into the payout currency.
  final String amount;

  /// Chargeback fee before conversion to the payout currency.
  /// null when the chargeback fee is the same as the payout currency.
  final OriginalChargebackFee? original;

  const ChargebackFee({required this.amount, this.original});

  factory ChargebackFee.fromJson(Map<String, dynamic> json) =>
      _$ChargebackFeeFromJson(json);

  Map<String, dynamic> toJson() => _$ChargebackFeeToJson(this);

  @override
  List<Object?> get props => [amount, original];
}

/// Chargeback fee before conversion to the payout currency.
@JsonSerializable()
final class OriginalChargebackFee with EquatableMixin {
  /// Fee amount for this chargeback in the original currency.
  final String amount;

  /// Three-letter ISO 4217 currency code for the original chargeback fee.
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  const OriginalChargebackFee({
    required this.amount,
    required this.currencyCode,
  });

  factory OriginalChargebackFee.fromJson(Map<String, dynamic> json) =>
      _$OriginalChargebackFeeFromJson(json);

  Map<String, dynamic> toJson() => _$OriginalChargebackFeeToJson(this);

  @override
  List<Object?> get props => [amount, currencyCode];
}

/// Paddle Checkout details for a transaction.
@JsonSerializable()
final class Checkout with EquatableMixin {
  /// Paddle Checkout URL for this transaction, composed of the URL passed
  /// in the request or your default payment URL + ?_ptxn= and the Paddle ID
  /// for this transaction.
  final String? url;

  const Checkout({this.url});

  factory Checkout.fromJson(Map<String, dynamic> json) =>
      _$CheckoutFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutToJson(this);

  @override
  List<Object?> get props => [url];
}
