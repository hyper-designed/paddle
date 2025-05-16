import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils.dart';

part 'customer_portal_session.g.dart';

/// Customer portal sessions hold authenticated links to the customer portal
/// for a customer.
///
/// The customer portal is a secure, Paddle-hosted site that customers can use
/// to manage their own subscriptions, payments, and account information.
///
/// You can create a customer portal session to generate authenticated links
/// to the customer portal.
/// This is typically used when linking to the customer portal from your app,
/// where customers are already authenticated.
///
/// Customer portal session entities hold authenticated links to the customer
/// portal for a customer, including:
///
/// Links to the customer portal overview page.
/// Deep links to that take customers to specific pages in the portal.
/// For example, the cancellation page for a specific subscription.
///
/// Customer portal sessions are temporary and shouldn't be cached.
@JsonSerializable()
final class CustomerPortalSession with EquatableMixin {
  /// Unique Paddle ID for this customer portal session entity,
  /// prefixed with cpls_.
  final String id;

  /// Paddle ID of the customer that this customer portal sessions is for,
  /// prefixed with ctm_.
  @JsonKey(name: 'customer_id')
  final String customerId;

  /// RFC 3339 datetime string of when this entity was created.
  /// Set automatically by Paddle.
  @DateTimeISO8601Converter()
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// Authenticated customer portal deep links. For security, the token
  /// appended to each link is temporary. You shouldn't store these links.
  final CustomerPortalUrls urls;

  const CustomerPortalSession({
    required this.id,
    required this.customerId,
    required this.createdAt,
    required this.urls,
  });

  factory CustomerPortalSession.fromJson(Map<String, dynamic> json) {
    if (json['data'] case Map<String, dynamic> data) {
      return _$CustomerPortalSessionFromJson(data);
    }
    return _$CustomerPortalSessionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CustomerPortalSessionToJson(this);

  @override
  List<Object?> get props => [id, customerId, createdAt, urls];
}

/// Authenticated customer portal deep links. For security, the token
/// appended to each link is temporary. You shouldn't store these links.
@JsonSerializable()
final class CustomerPortalUrls with EquatableMixin {
  /// Authenticated customer portal deep links that aren't associated
  /// with a specific entity.
  final GeneralPortalLinks general;

  /// List of generated authenticated customer portal deep links for the
  /// subscriptions passed in the subscription_ids array in the request.
  /// If subscriptions are paused or canceled, links open the overview page
  /// for a subscription. Empty if no subscriptions passed in the request.
  final List<PortalSubscriptionLink> subscriptions;

  const CustomerPortalUrls({
    required this.general,
    required this.subscriptions,
  });

  factory CustomerPortalUrls.fromJson(Map<String, dynamic> json) =>
      _$CustomerPortalUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerPortalUrlsToJson(this);

  @override
  List<Object?> get props => [general, subscriptions];
}

/// Authenticated customer portal deep links that aren't associated
/// with a specific entity.
@JsonSerializable()
final class GeneralPortalLinks with EquatableMixin {
  /// Link to the overview page in the customer portal.
  final String overview;

  const GeneralPortalLinks({required this.overview});

  factory GeneralPortalLinks.fromJson(Map<String, dynamic> json) =>
      _$GeneralPortalLinksFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralPortalLinksToJson(this);

  @override
  List<Object?> get props => [overview];
}

/// Authenticated customer portal deep links for a subscription.
@JsonSerializable()
final class PortalSubscriptionLink with EquatableMixin {
  /// Paddle ID of the subscription that the authenticated customer portal
  /// deep links are for.
  final String id;

  /// Link to the page for this subscription in the customer portal with the
  /// subscription cancellation form pre-opened. Use as part of cancel
  /// subscription workflows.
  @JsonKey(name: 'cancel_subscription')
  final String cancelSubscription;

  /// Link to the page for this subscription in the customer portal with the
  /// payment method update form pre-opened. Use as part of workflows to let
  /// customers update their payment details.
  ///
  /// If a manually-collected subscription, opens the overview page for this
  /// subscription.
  @JsonKey(name: 'update_subscription_payment_method')
  final String updateSubscriptionPaymentMethod;

  const PortalSubscriptionLink({
    required this.id,
    required this.cancelSubscription,
    required this.updateSubscriptionPaymentMethod,
  });

  factory PortalSubscriptionLink.fromJson(Map<String, dynamic> json) =>
      _$PortalSubscriptionLinkFromJson(json);

  Map<String, dynamic> toJson() => _$PortalSubscriptionLinkToJson(this);

  @override
  List<Object?> get props => [
    id,
    cancelSubscription,
    updateSubscriptionPaymentMethod,
  ];
}
