// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardDetails _$CardDetailsFromJson(Map<String, dynamic> json) => CardDetails(
  type: json['type'] as String,
  last4: json['last4'] as String,
  expiryMonth: (json['expiry_month'] as num).toInt(),
  expiryYear: (json['expiry_year'] as num).toInt(),
  cardholderName: json['cardholder_name'] as String,
);

Map<String, dynamic> _$CardDetailsToJson(CardDetails instance) =>
    <String, dynamic>{
      'type': instance.type,
      'last4': instance.last4,
      'expiry_month': instance.expiryMonth,
      'expiry_year': instance.expiryYear,
      'cardholder_name': instance.cardholderName,
    };

KoreaLocalDetails _$KoreaLocalDetailsFromJson(Map<String, dynamic> json) =>
    KoreaLocalDetails(type: json['type'] as String);

Map<String, dynamic> _$KoreaLocalDetailsToJson(KoreaLocalDetails instance) =>
    <String, dynamic>{'type': instance.type};

UnderlyingDetails _$UnderlyingDetailsFromJson(Map<String, dynamic> json) =>
    UnderlyingDetails(
      koreaLocal:
          json['korea_local'] == null
              ? null
              : KoreaLocalDetails.fromJson(
                json['korea_local'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$UnderlyingDetailsToJson(UnderlyingDetails instance) =>
    <String, dynamic>{'korea_local': instance.koreaLocal};

MethodDetails _$MethodDetailsFromJson(Map<String, dynamic> json) =>
    MethodDetails(
      type: $enumDecode(_$PaymentMethodTypeEnumMap, json['type']),
      card:
          json['card'] == null
              ? null
              : CardDetails.fromJson(json['card'] as Map<String, dynamic>),
      underlyingDetails:
          json['underlying_details'] == null
              ? null
              : UnderlyingDetails.fromJson(
                json['underlying_details'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$MethodDetailsToJson(MethodDetails instance) =>
    <String, dynamic>{
      'type': _$PaymentMethodTypeEnumMap[instance.type]!,
      'card': instance.card,
      'underlying_details': instance.underlyingDetails,
    };

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.alipay: 'alipay',
  PaymentMethodType.applePay: 'apple_pay',
  PaymentMethodType.bancontact: 'bancontact',
  PaymentMethodType.card: 'card',
  PaymentMethodType.googlePay: 'google_pay',
  PaymentMethodType.ideal: 'ideal',
  PaymentMethodType.koreaLocal: 'korea_local',
  PaymentMethodType.offline: 'offline',
  PaymentMethodType.paypal: 'paypal',
  PaymentMethodType.unknown: 'unknown',
  PaymentMethodType.wireTransfer: 'wire_transfer',
};

PaymentAttempt _$PaymentAttemptFromJson(Map<String, dynamic> json) =>
    PaymentAttempt(
      paymentAttemptId: json['payment_attempt_id'] as String,
      storedPaymentMethodId: json['stored_payment_method_id'] as String,
      paymentMethodId: json['payment_method_id'] as String?,
      amount: json['amount'] as String,
      status: $enumDecode(_$PaymentAttemptStatusEnumMap, json['status']),
      errorCode: $enumDecodeNullable(
        _$PaymentErrorCodeEnumMap,
        json['error_code'],
      ),
      methodDetails: MethodDetails.fromJson(
        json['method_details'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      capturedAt:
          json['captured_at'] == null
              ? null
              : DateTime.parse(json['captured_at'] as String),
    );

Map<String, dynamic> _$PaymentAttemptToJson(PaymentAttempt instance) =>
    <String, dynamic>{
      'payment_attempt_id': instance.paymentAttemptId,
      'stored_payment_method_id': instance.storedPaymentMethodId,
      'payment_method_id': instance.paymentMethodId,
      'amount': instance.amount,
      'status': _$PaymentAttemptStatusEnumMap[instance.status]!,
      'error_code': _$PaymentErrorCodeEnumMap[instance.errorCode],
      'method_details': instance.methodDetails,
      'created_at': instance.createdAt.toIso8601String(),
      'captured_at': instance.capturedAt?.toIso8601String(),
    };

const _$PaymentAttemptStatusEnumMap = {
  PaymentAttemptStatus.authorized: 'authorized',
  PaymentAttemptStatus.authorizedFlagged: 'authorized_flagged',
  PaymentAttemptStatus.canceled: 'canceled',
  PaymentAttemptStatus.captured: 'captured',
  PaymentAttemptStatus.error: 'error',
  PaymentAttemptStatus.actionRequired: 'action_required',
  PaymentAttemptStatus.pendingNoActionRequired: 'pending_no_action_required',
  PaymentAttemptStatus.created: 'created',
  PaymentAttemptStatus.unknown: 'unknown',
  PaymentAttemptStatus.dropped: 'dropped',
};

const _$PaymentErrorCodeEnumMap = {
  PaymentErrorCode.alreadyCanceled: 'already_canceled',
  PaymentErrorCode.alreadyRefunded: 'already_refunded',
  PaymentErrorCode.authenticationFailed: 'authentication_failed',
  PaymentErrorCode.blockedCard: 'blocked_card',
  PaymentErrorCode.canceled: 'canceled',
  PaymentErrorCode.declined: 'declined',
  PaymentErrorCode.declinedNotRetryable: 'declined_not_retryable',
  PaymentErrorCode.expiredCard: 'expired_card',
  PaymentErrorCode.fraud: 'fraud',
  PaymentErrorCode.invalidAmount: 'invalid_amount',
  PaymentErrorCode.invalidPaymentDetails: 'invalid_payment_details',
  PaymentErrorCode.issuerUnavailable: 'issuer_unavailable',
  PaymentErrorCode.notEnoughBalance: 'not_enough_balance',
  PaymentErrorCode.preferredNetworkNotSupported:
      'preferred_network_not_supported',
  PaymentErrorCode.pspError: 'psp_error',
  PaymentErrorCode.redactedPaymentMethod: 'redacted_payment_method',
  PaymentErrorCode.systemError: 'system_error',
  PaymentErrorCode.transactionNotPermitted: 'transaction_not_permitted',
  PaymentErrorCode.unknown: 'unknown',
};
