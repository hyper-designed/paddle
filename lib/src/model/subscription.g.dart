// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionList _$SubscriptionListFromJson(Map<String, dynamic> json) =>
    SubscriptionList(
      meta: ResourceMeta.fromJson(json['meta'] as Map<String, dynamic>),
      data:
          (json['data'] as List<dynamic>)
              .map((e) => Subscription.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$SubscriptionListToJson(SubscriptionList instance) =>
    <String, dynamic>{'meta': instance.meta, 'data': instance.data};

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
  id: json['id'] as String,
  status: $enumDecode(_$SubscriptionStatusEnumMap, json['status']),
  customerId: json['customer_id'] as String,
  addressId: json['address_id'] as String,
  businessId: json['business_id'] as String?,
  currencyCode: json['currency_code'] as String,
  startedAt: _$JsonConverterFromJson<String, DateTime>(
    json['started_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
  firstBilledAt: _$JsonConverterFromJson<String, DateTime>(
    json['first_billed_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
  nextBilledAt: _$JsonConverterFromJson<String, DateTime>(
    json['next_billed_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
  pausedAt: _$JsonConverterFromJson<String, DateTime>(
    json['paused_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
  canceledAt: _$JsonConverterFromJson<String, DateTime>(
    json['canceled_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
  discount:
      json['discount'] == null
          ? null
          : Discount.fromJson(json['discount'] as Map<String, dynamic>),
  collectionMode: $enumDecode(_$CollectionModeEnumMap, json['collection_mode']),
  billingDetails:
      json['billing_details'] == null
          ? null
          : BillingDetails.fromJson(
            json['billing_details'] as Map<String, dynamic>,
          ),
  currentBillingPeriod:
      json['current_billing_period'] == null
          ? null
          : BillingPeriod.fromJson(
            json['current_billing_period'] as Map<String, dynamic>,
          ),
  billingCycle:
      json['billing_cycle'] == null
          ? null
          : Period.fromJson(json['billing_cycle'] as Map<String, dynamic>),
  scheduledChange:
      json['scheduled_change'] == null
          ? null
          : ScheduledChange.fromJson(
            json['scheduled_change'] as Map<String, dynamic>,
          ),
  managementUrls:
      json['management_urls'] == null
          ? null
          : ManagementUrls.fromJson(
            json['management_urls'] as Map<String, dynamic>,
          ),
  items:
      (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
  customData: json['custom_data'] as Map<String, dynamic>?,
  importMeta:
      json['import_meta'] == null
          ? null
          : ImportMeta.fromJson(json['import_meta'] as Map<String, dynamic>),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'custom_data': instance.customData,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'import_meta': instance.importMeta,
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
      'customer_id': instance.customerId,
      'address_id': instance.addressId,
      'business_id': instance.businessId,
      'currency_code': instance.currencyCode,
      'started_at': _$JsonConverterToJson<String, DateTime>(
        instance.startedAt,
        const DateTimeISO8601Converter().toJson,
      ),
      'first_billed_at': _$JsonConverterToJson<String, DateTime>(
        instance.firstBilledAt,
        const DateTimeISO8601Converter().toJson,
      ),
      'next_billed_at': _$JsonConverterToJson<String, DateTime>(
        instance.nextBilledAt,
        const DateTimeISO8601Converter().toJson,
      ),
      'paused_at': _$JsonConverterToJson<String, DateTime>(
        instance.pausedAt,
        const DateTimeISO8601Converter().toJson,
      ),
      'canceled_at': _$JsonConverterToJson<String, DateTime>(
        instance.canceledAt,
        const DateTimeISO8601Converter().toJson,
      ),
      'discount': instance.discount,
      'collection_mode': _$CollectionModeEnumMap[instance.collectionMode]!,
      'billing_details': instance.billingDetails,
      'current_billing_period': instance.currentBillingPeriod,
      'billing_cycle': instance.billingCycle,
      'scheduled_change': instance.scheduledChange,
      'management_urls': instance.managementUrls,
      'items': instance.items,
    };

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.active: 'active',
  SubscriptionStatus.canceled: 'canceled',
  SubscriptionStatus.pastDue: 'past_due',
  SubscriptionStatus.paused: 'paused',
  SubscriptionStatus.trialing: 'trialing',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

const _$CollectionModeEnumMap = {
  CollectionMode.automatic: 'automatic',
  CollectionMode.manual: 'manual',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

Discount _$DiscountFromJson(Map<String, dynamic> json) => Discount(
  endsAt: _$JsonConverterFromJson<String, DateTime>(
    json['ends_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
  id: json['id'] as String,
  startsAt: _$JsonConverterFromJson<String, DateTime>(
    json['starts_at'],
    const DateTimeISO8601Converter().fromJson,
  ),
);

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
  'ends_at': _$JsonConverterToJson<String, DateTime>(
    instance.endsAt,
    const DateTimeISO8601Converter().toJson,
  ),
  'id': instance.id,
  'starts_at': _$JsonConverterToJson<String, DateTime>(
    instance.startsAt,
    const DateTimeISO8601Converter().toJson,
  ),
};

BillingDetails _$BillingDetailsFromJson(Map<String, dynamic> json) =>
    BillingDetails(
      paymentTerms: PaymentTerms.fromJson(
        json['payment_terms'] as Map<String, dynamic>,
      ),
      enableCheckout: json['enable_checkout'] as bool,
      purchaseOrderNumber: json['purchase_order_number'] as String,
      additionalInformation: json['additional_information'] as String?,
    );

Map<String, dynamic> _$BillingDetailsToJson(BillingDetails instance) =>
    <String, dynamic>{
      'payment_terms': instance.paymentTerms,
      'enable_checkout': instance.enableCheckout,
      'purchase_order_number': instance.purchaseOrderNumber,
      'additional_information': instance.additionalInformation,
    };

PaymentTerms _$PaymentTermsFromJson(Map<String, dynamic> json) => PaymentTerms(
  interval: $enumDecode(_$IntervalEnumMap, json['interval']),
  frequency: (json['frequency'] as num).toInt(),
);

Map<String, dynamic> _$PaymentTermsToJson(PaymentTerms instance) =>
    <String, dynamic>{
      'interval': _$IntervalEnumMap[instance.interval]!,
      'frequency': instance.frequency,
    };

const _$IntervalEnumMap = {
  Interval.day: 'day',
  Interval.week: 'week',
  Interval.month: 'month',
  Interval.year: 'year',
};

ScheduledChange _$ScheduledChangeFromJson(Map<String, dynamic> json) =>
    ScheduledChange(
      action: $enumDecode(_$ScheduledChangeActionEnumMap, json['action']),
      effectiveAt: const DateTimeISO8601Converter().fromJson(
        json['effective_at'] as String,
      ),
      resumeAt: _$JsonConverterFromJson<String, DateTime>(
        json['resume_at'],
        const DateTimeISO8601Converter().fromJson,
      ),
    );

Map<String, dynamic> _$ScheduledChangeToJson(
  ScheduledChange instance,
) => <String, dynamic>{
  'action': _$ScheduledChangeActionEnumMap[instance.action]!,
  'effective_at': const DateTimeISO8601Converter().toJson(instance.effectiveAt),
  'resume_at': _$JsonConverterToJson<String, DateTime>(
    instance.resumeAt,
    const DateTimeISO8601Converter().toJson,
  ),
};

const _$ScheduledChangeActionEnumMap = {
  ScheduledChangeAction.cancel: 'cancel',
  ScheduledChangeAction.pause: 'pause',
  ScheduledChangeAction.resume: 'resume',
};

ManagementUrls _$ManagementUrlsFromJson(Map<String, dynamic> json) =>
    ManagementUrls(
      updatePaymentMethod: json['update_payment_method'] as String?,
      cancel: json['cancel'] as String,
    );

Map<String, dynamic> _$ManagementUrlsToJson(ManagementUrls instance) =>
    <String, dynamic>{
      'update_payment_method': instance.updatePaymentMethod,
      'cancel': instance.cancel,
    };
