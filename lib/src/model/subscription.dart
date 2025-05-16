import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paddle/src/model/item.dart';

import '../../paddle.dart';
import '../utils.dart';
import 'billing_cycle.dart';

part 'subscription.g.dart';

@JsonSerializable()
class SubscriptionList extends ResourceList<Subscription> {
  SubscriptionList({required super.meta, required super.data});

  factory SubscriptionList.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SubscriptionListToJson(this);

  @override
  SubscriptionList copyWith({ResourceMeta? meta, List<Subscription>? data}) =>
      SubscriptionList(meta: meta ?? this.meta, data: data ?? this.data);
}

/// Status of this subscription. Set automatically by Paddle.
/// Use the pause subscription or cancel subscription operations to change.
enum SubscriptionStatus {
  /// Subscription is active. Paddle is billing for this subscription and
  /// related transactions aren't past due.
  active,

  /// Subscription is canceled. Automatically set by Paddle when a
  /// subscription is canceled. When a subscription is set to cancel on the
  /// next billing period, a scheduled change for the cancellation is created.
  /// The subscription status moves to canceled when the scheduled change
  /// takes effect.
  canceled,

  /// Subscription has an overdue payment. Automatically set by Paddle when
  /// payment fails for an automatically-collected transaction, or when payment
  /// terms have elapsed for a manually-collected transaction (an invoice).
  @JsonValue('past_due')
  pastDue,

  /// Subscription is paused. Automatically set by Paddle when a subscription
  /// is paused. When a subscription is set to pause on the next billing
  /// period, a scheduled change for the pause is created. The subscription
  /// status moves to paused when the scheduled change takes effect.
  paused,

  /// Subscription is in trial.
  trialing,
}

/// How payment is collected for transactions created for this subscription.
/// automatic for checkout, manual for invoices.
enum CollectionMode {
  /// Payment is collected automatically using a checkout initially, then
  /// using a payment method on file.
  automatic,

  /// Payment is collected manually. Customers are sent an invoice with payment
  /// terms and can make a payment offline or using a checkout.
  /// Requires billing_details.
  manual,
}

/// Kind of change that's scheduled to be applied to this subscription.
enum ScheduledChangeAction {
  /// Subscription is scheduled to cancel. Its status changes to canceled
  /// on the effective_at date.
  cancel,

  /// Subscription is scheduled to pause. Its status changes to pause
  /// on the effective_at date.
  pause,

  /// Subscription is scheduled to resume. Its status changes to active
  /// on the resume_at date.
  resume,
}

/// Subscription entities describe a recurring billing relationship with a
/// customer. They're closely related to transactions.
///
/// Subscriptions let customers pay for products on a recurring schedule.
/// They hold information about what Paddle should charge a customer for
/// and how often.
///
/// Subscription entities hold information like:
///
/// Who the customer is.
/// Which prices a customer has subscribed to.
/// How often a subscription renews.
/// Details about trial periods.
/// Any upcoming scheduled changes.
///
/// Subscriptions work with products, prices, and discounts to say what a
/// customer has subscribed to, and customers, addresses, and businesses to
/// say who the customer is.
@JsonSerializable()
final class Subscription extends ResourceData {
  /// Status of this subscription. Set automatically by Paddle. Use the pause
  /// subscription or cancel subscription operations to change.
  final SubscriptionStatus status;

  /// Paddle ID of the customer that this subscription is for,
  /// prefixed with ctm_.
  @JsonKey(name: 'customer_id')
  final String customerId;

  /// Paddle ID of the address that this subscription is for,
  /// prefixed with add_.
  @JsonKey(name: 'address_id')
  final String addressId;

  /// Paddle ID of the business that this subscription is for,
  /// prefixed with biz_.
  @JsonKey(name: 'business_id')
  final String? businessId;

  /// Supported three-letter ISO 4217 currency code. Transactions for this
  /// subscription are created in this currency. Must be USD, EUR, or GBP
  /// if collection_mode is manual.
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// RFC 3339 datetime string of when this entity was created.
  /// Set automatically by Paddle.
  /// RFC 3339 datetime string of when this subscription started.
  /// This may be different from first_billed_at if the subscription started
  /// in trial.
  @JsonKey(name: 'started_at')
  @DateTimeISO8601Converter()
  final DateTime? startedAt;

  /// RFC 3339 datetime string of when this subscription was first billed.
  /// This may be different from started_at if the subscription started
  /// in trial.
  @JsonKey(name: 'first_billed_at')
  @DateTimeISO8601Converter()
  final DateTime? firstBilledAt;

  /// RFC 3339 datetime string of when this subscription is next scheduled
  /// to be billed.
  @JsonKey(name: 'next_billed_at')
  @DateTimeISO8601Converter()
  final DateTime? nextBilledAt;

  /// RFC 3339 datetime string of when this subscription was paused.
  /// Set automatically by Paddle when the pause subscription operation is
  /// used. null if not paused.
  @JsonKey(name: 'paused_at')
  @DateTimeISO8601Converter()
  final DateTime? pausedAt;

  /// RFC 3339 datetime string of when this subscription was canceled.
  /// Set automatically by Paddle when the cancel subscription operation is
  /// used. null if not canceled.
  @JsonKey(name: 'canceled_at')
  @DateTimeISO8601Converter()
  final DateTime? canceledAt;

  /// Details of the discount applied to this subscription.
  final Discount? discount;

  /// How payment is collected for transactions created for this subscription.
  /// automatic for checkout, manual for invoices.
  @JsonKey(name: 'collection_mode')
  final CollectionMode collectionMode;

  /// Details for invoicing. Required if collection_mode is manual.
  @JsonKey(name: 'billing_details')
  final BillingDetails? billingDetails;

  /// Current billing period for this subscription. Set automatically by
  /// Paddle based on the billing cycle. null for paused and canceled
  /// subscriptions.
  @JsonKey(name: 'current_billing_period')
  final CurrentBillingPeriod? currentBillingPeriod;

  /// How often this subscription renews. Set automatically by Paddle based
  /// on the prices on this subscription.
  @JsonKey(name: 'billing_cycle')
  final BillingCycle? billingCycle;

  /// Change that's scheduled to be applied to a subscription.
  /// Use the pause subscription, cancel subscription, and resume subscription
  /// operations to create scheduled changes. null if no scheduled changes.
  @JsonKey(name: 'scheduled_change')
  final ScheduledChange? scheduledChange;

  /// Authenticated customer portal deep links for this subscription.
  /// For security, the token appended to each link is temporary.
  /// You shouldn't store these links.
  /// TODO: Do we need to json ignore this?
  @JsonKey(name: 'management_urls')
  final ManagementUrls? managementUrls;

  /// List of items on this subscription. Only recurring items are returned.
  final List<Item> items;

  const Subscription({
    required super.id,
    required this.status,
    required this.customerId,
    required this.addressId,
    required this.businessId,
    required this.currencyCode,
    required this.startedAt,
    required this.firstBilledAt,
    required this.nextBilledAt,
    required this.pausedAt,
    required this.canceledAt,
    required this.discount,
    required this.collectionMode,
    required this.billingDetails,
    required this.currentBillingPeriod,
    required this.billingCycle,
    required this.scheduledChange,
    required this.managementUrls,
    required this.items,
    required super.customData,
    super.importMeta,
    required super.createdAt,
    required super.updatedAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  @override
  List<Object?> get props => [
    ...super.props,
    status,
    customerId,
    addressId,
    businessId,
    currencyCode,
    startedAt,
    firstBilledAt,
    nextBilledAt,
    pausedAt,
    canceledAt,
    discount,
    collectionMode,
    billingDetails,
    currentBillingPeriod,
    billingCycle,
    scheduledChange,
    managementUrls,
    items,
  ];
}

/// Details of the discount applied to this subscription.
@JsonSerializable()
final class Discount with EquatableMixin {
  /// RFC 3339 datetime string of when this discount no longer applies.
  /// Where a discount has maximum_recurring_intervals, this is the date of the
  /// last billing period where this discount applies. null where a discount
  /// recurs forever.
  @JsonKey(name: 'ends_at')
  @DateTimeISO8601Converter()
  final DateTime? endsAt;

  /// Unique Paddle ID for this discount, prefixed with dsc_.
  final String id;

  /// RFC 3339 datetime string of when this discount was first applied.
  /// null for canceled subscriptions where a discount was redeemed but never
  /// applied to a transaction.
  @JsonKey(name: 'starts_at')
  @DateTimeISO8601Converter()
  final DateTime? startsAt;

  const Discount({
    required this.endsAt,
    required this.id,
    required this.startsAt,
  });

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountToJson(this);

  @override
  List<Object?> get props => [endsAt, id, startsAt];
}

/// Details for invoicing. Required if collection_mode is manual.
@JsonSerializable()
final class BillingDetails with EquatableMixin {
  /// How long a customer has to pay this invoice once issued.
  @JsonKey(name: 'payment_terms')
  final PaymentTerms paymentTerms;

  /// Whether the related transaction may be paid using Paddle Checkout.
  /// If omitted when creating a transaction, defaults to false.
  @JsonKey(name: 'enable_checkout')
  final bool enableCheckout;

  /// Customer purchase order number. Appears on invoice documents.
  @JsonKey(name: 'purchase_order_number')
  final String purchaseOrderNumber;

  /// Notes or other information to include on this invoice.
  /// Appears on invoice documents.
  @JsonKey(name: 'additional_information')
  final String? additionalInformation;

  const BillingDetails({
    required this.paymentTerms,
    required this.enableCheckout,
    required this.purchaseOrderNumber,
    required this.additionalInformation,
  });

  factory BillingDetails.fromJson(Map<String, dynamic> json) =>
      _$BillingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BillingDetailsToJson(this);

  @override
  List<Object?> get props => [
    paymentTerms,
    enableCheckout,
    purchaseOrderNumber,
    additionalInformation,
  ];
}

/// How long a customer has to pay this invoice once issued.
@JsonSerializable()
final class PaymentTerms with EquatableMixin {
  /// Unit of time.
  final Interval interval;

  /// Amount of time.
  final int frequency;

  const PaymentTerms({required this.interval, required this.frequency});

  factory PaymentTerms.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTermsToJson(this);

  @override
  List<Object?> get props => [interval, frequency];
}

/// Current billing period for this subscription. Set automatically by Paddle
/// based on the billing cycle. null for paused and canceled subscriptions.
@JsonSerializable()
final class CurrentBillingPeriod with EquatableMixin {
  /// RFC 3339 datetime string of when this period starts.
  @JsonKey(name: 'starts_at')
  @DateTimeISO8601Converter()
  final DateTime startsAt;

  /// RFC 3339 datetime string of when this period ends.
  @JsonKey(name: 'ends_at')
  @DateTimeISO8601Converter()
  final DateTime endsAt;

  const CurrentBillingPeriod({required this.startsAt, required this.endsAt});

  factory CurrentBillingPeriod.fromJson(Map<String, dynamic> json) =>
      _$CurrentBillingPeriodFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentBillingPeriodToJson(this);

  @override
  List<Object?> get props => [startsAt, endsAt];
}

/// Change that's scheduled to be applied to a subscription.
@JsonSerializable()
final class ScheduledChange with EquatableMixin {
  /// Kind of change that's scheduled to be applied to this subscription.
  final ScheduledChangeAction action;

  /// RFC 3339 datetime string of when this scheduled change takes effect.
  @JsonKey(name: 'effective_at')
  @DateTimeISO8601Converter()
  final DateTime effectiveAt;

  /// RFC 3339 datetime string of when a paused subscription should resume.
  /// Only used for pause scheduled changes.
  @JsonKey(name: 'resume_at')
  @DateTimeISO8601Converter()
  final DateTime? resumeAt;

  const ScheduledChange({
    required this.action,
    required this.effectiveAt,
    this.resumeAt,
  });

  factory ScheduledChange.fromJson(Map<String, dynamic> json) =>
      _$ScheduledChangeFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduledChangeToJson(this);

  @override
  List<Object?> get props => [action, effectiveAt, resumeAt];
}

/// Authenticated customer portal deep links for this subscription.
/// For security, the token appended to each link is temporary.
/// You shouldn't store these links.
/// TODO: Do we need to json ignore this?
@JsonSerializable()
final class ManagementUrls with EquatableMixin {
  /// Link to the page for this subscription in the customer portal with
  /// the payment method update form pre-opened. Use as part of workflows to
  /// let customers update their payment details. null for manually-collected
  /// subscriptions.
  @JsonKey(name: 'update_payment_method')
  final String? updatePaymentMethod;

  /// Link to the page for this subscription in the customer portal with the
  /// subscription cancellation form pre-opened. Use as part of cancel
  /// subscription workflows.
  final String cancel;

  const ManagementUrls({this.updatePaymentMethod, required this.cancel});

  factory ManagementUrls.fromJson(Map<String, dynamic> json) =>
      _$ManagementUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$ManagementUrlsToJson(this);

  @override
  List<Object?> get props => [updatePaymentMethod, cancel];
}
