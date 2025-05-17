import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method.g.dart';

/// Type of payment method used for a payment attempt.
enum PaymentMethodType {
  /// Alipay, popular in China.
  alipay,

  /// Apple Pay on a supported Apple device.
  @JsonValue('apple_pay')
  applePay,

  /// Bancontact, popular in Belgium.
  bancontact,

  /// Credit or debit card.
  card,

  /// Google Pay on a supported Android device, Chromebook, or Google Chrome
  /// browser.
  @JsonValue('google_pay')
  googlePay,

  /// iDEAL, popular in the Netherlands.
  ideal,

  /// Korean payment methods, which includes over 20 payment options for the
  /// Korean market.
  @JsonValue('korea_local')
  koreaLocal,

  /// Payment recorded offline.
  offline,

  /// PayPal.
  paypal,

  /// Payment method not known.
  unknown,

  /// Wire transfer, sometimes called bank transfer.
  @JsonValue('wire_transfer')
  wireTransfer,
}

/// Status of a payment attempt.
enum PaymentAttemptStatus {
  /// Authorized but not captured. Payment attempt is incomplete.
  authorized,

  /// Authorized but not captured because it has been flagged as potentially
  /// fraudulent.
  /// Payment attempt is incomplete.
  @JsonValue('authorized_flagged')
  authorizedFlagged,

  /// Previously authorized payment attempt has been canceled.
  /// Typically when authorized_flagged payment attempts are rejected.
  canceled,

  /// Payment captured successfully. Payment attempt is complete.
  captured,

  /// Something went wrong and the payment attempt was unsuccessful.
  /// Check the error_code for more information.
  error,

  /// Customer must complete an action for this payment attempt to proceed.
  /// Typically means that the payment attempt requires 3DS.
  @JsonValue('action_required')
  actionRequired,

  /// Response required from the bank or payment provider. Transaction is
  /// pending.
  @JsonValue('pending_no_action_required')
  pendingNoActionRequired,

  /// New payment attempt created.
  created,

  /// Payment attempt status not known.
  unknown,

  /// Payment attempt dropped by Paddle.
  dropped,
}

/// Reason why a payment attempt failed.
enum PaymentErrorCode {
  /// Cancellation not possible because the amount has already been canceled.
  /// Not typically returned for payments.
  @JsonValue('already_canceled')
  alreadyCanceled,

  /// Refund is not possible because the amount has already been refunded.
  /// Not typically returned for payments.
  @JsonValue('already_refunded')
  alreadyRefunded,

  /// Payment required a 3DS2 authentication challenge.
  /// The customer completed the challenge but was not successful.
  @JsonValue('authentication_failed')
  authenticationFailed,

  /// Payment method issuer has indicated that the card cannot be used as
  /// it is frozen, lost, damaged, or stolen.
  @JsonValue('blocked_card')
  blockedCard,

  /// Customer has requested that the mandate for recurring payments be
  /// canceled.
  canceled,

  /// Payment method has been declined, with no other information returned.
  declined,

  /// Payment method has been declined, and the issuer has indicated that
  /// it should not be retried. This could mean the account is closed or
  /// the customer revoked authorization to charge the payment method.
  @JsonValue('declined_not_retryable')
  declinedNotRetryable,

  /// Payment method issuer has indicated that this card is expired.
  /// Expired cards may also return invalid_payment_details, depending on
  /// how a payment is routed.
  @JsonValue('expired_card')
  expiredCard,

  /// Payment method issuer or payment service provider flagged this payment
  /// as potentially fraudulent.
  fraud,

  /// Payment method issuer or payment service provider cannot process
  /// a payment that is this high or low.
  @JsonValue('invalid_amount')
  invalidAmount,

  /// Payment service provider has indicated the payment method isn't valid.
  /// This typically means that it's expired. expired_card is returned by the
  /// payment method issuer, rather than the payment service provider.
  @JsonValue('invalid_payment_details')
  invalidPaymentDetails,

  /// Payment service provider couldn't reach the payment method issuer.
  @JsonValue('issuer_unavailable')
  issuerUnavailable,

  /// Payment method declined because of insufficient funds, or fund limits
  /// being reached.
  @JsonValue('not_enough_balance')
  notEnoughBalance,

  /// Payment method has been declined because the network scheme that the
  /// customer selected isn't supported by the payment service provider.
  @JsonValue('preferred_network_not_supported')
  preferredNetworkNotSupported,

  /// Something went wrong with the payment service provider, with no other
  /// information returned.
  @JsonValue('psp_error')
  pspError,

  /// Payment service provider didn't receive payment method information
  /// as they've been redacted.
  @JsonValue('redacted_payment_method')
  redactedPaymentMethod,

  /// Something went wrong with the Paddle platform. Try again later, or check
  /// status.paddle.com.
  @JsonValue('system_error')
  systemError,

  /// Payment method issuer doesn't allow this kind of payment because of
  /// limits on the account, or legal or compliance reasons.
  @JsonValue('transaction_not_permitted')
  transactionNotPermitted,

  /// Payment attempt unsuccessful, with no other information returned.
  unknown,
}

/// Information about the card used to pay.
@JsonSerializable()
final class CardDetails with EquatableMixin {
  /// Type of credit or debit card used to pay.
  final String type;

  /// Last four digits of the card used to pay.
  final String last4;

  /// Month of the expiry date of the card used to pay.
  @JsonKey(name: 'expiry_month')
  final int expiryMonth;

  /// Year of the expiry date of the card used to pay.
  @JsonKey(name: 'expiry_year')
  final int expiryYear;

  /// The name on the card used to pay.
  @JsonKey(name: 'cardholder_name')
  final String cardholderName;

  const CardDetails({
    required this.type,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cardholderName,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) =>
      _$CardDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CardDetailsToJson(this);

  @override
  List<Object?> get props => [
    type,
    last4,
    expiryMonth,
    expiryYear,
    cardholderName,
  ];
}

/// Information about the Korean payment method used to pay.
@JsonSerializable()
final class KoreaLocalDetails with EquatableMixin {
  /// Type of Korean payment method used to pay.
  final String type;

  const KoreaLocalDetails({required this.type});

  factory KoreaLocalDetails.fromJson(Map<String, dynamic> json) =>
      _$KoreaLocalDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$KoreaLocalDetailsToJson(this);

  @override
  List<Object?> get props => [type];
}

/// Information about the underlying payment method used to pay.
@JsonSerializable()
final class UnderlyingDetails with EquatableMixin {
  /// Information about the Korean payment method used to pay.
  /// null unless the type is korea_local.
  @JsonKey(name: 'korea_local')
  final KoreaLocalDetails? koreaLocal;

  const UnderlyingDetails({this.koreaLocal});

  factory UnderlyingDetails.fromJson(Map<String, dynamic> json) =>
      _$UnderlyingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UnderlyingDetailsToJson(this);

  @override
  List<Object?> get props => [koreaLocal];
}

/// Information about the payment method used for a payment attempt.
@JsonSerializable()
final class MethodDetails with EquatableMixin {
  /// Type of payment method used for this payment attempt.
  final PaymentMethodType type;

  /// Information about the credit or debit card used to pay.
  /// null unless type is card.
  final CardDetails? card;

  /// Information about the underlying payment method used to pay.
  /// Populated for payment methods that offer multiple payment options,
  /// like korea_local.
  @JsonKey(name: 'underlying_details')
  final UnderlyingDetails? underlyingDetails;

  const MethodDetails({required this.type, this.card, this.underlyingDetails});

  factory MethodDetails.fromJson(Map<String, dynamic> json) =>
      _$MethodDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MethodDetailsToJson(this);

  @override
  List<Object?> get props => [type, card, underlyingDetails];
}

/// Information about a payment attempt for a transaction.
@JsonSerializable()
final class PaymentAttempt with EquatableMixin {
  /// UUID for this payment attempt.
  @JsonKey(name: 'payment_attempt_id')
  final String paymentAttemptId;

  /// UUID for the stored payment method used for this payment attempt.
  /// Deprecated - use payment_method_id instead.
  @JsonKey(name: 'stored_payment_method_id')
  final String storedPaymentMethodId;

  /// Paddle ID of the payment method used for this payment attempt, prefixed
  /// with paymtd_.
  @JsonKey(name: 'payment_method_id')
  final String? paymentMethodId;

  /// Amount for collection in the lowest denomination of a currency
  /// (e.g. cents for USD).
  final String amount;

  /// Status of this payment attempt.
  final PaymentAttemptStatus status;

  /// Reason why a payment attempt failed.
  /// Returns null if payment captured successfully.
  @JsonKey(name: 'error_code')
  final PaymentErrorCode? errorCode;

  /// Information about the payment method used for a payment attempt.
  @JsonKey(name: 'method_details')
  final MethodDetails methodDetails;

  /// RFC 3339 datetime string of when this entity was created.
  /// Set automatically by Paddle.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// RFC 3339 datetime string of when this payment was captured.
  /// null if status is not captured.
  @JsonKey(name: 'captured_at')
  final DateTime? capturedAt;

  const PaymentAttempt({
    required this.paymentAttemptId,
    required this.storedPaymentMethodId,
    this.paymentMethodId,
    required this.amount,
    required this.status,
    this.errorCode,
    required this.methodDetails,
    required this.createdAt,
    this.capturedAt,
  });

  factory PaymentAttempt.fromJson(Map<String, dynamic> json) =>
      _$PaymentAttemptFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentAttemptToJson(this);

  @override
  List<Object?> get props => [
    paymentAttemptId,
    storedPaymentMethodId,
    paymentMethodId,
    amount,
    status,
    errorCode,
    methodDetails,
    createdAt,
    capturedAt,
  ];
}
