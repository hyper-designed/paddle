// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_portal_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerPortalSession _$CustomerPortalSessionFromJson(
  Map<String, dynamic> json,
) => CustomerPortalSession(
  id: json['id'] as String,
  customerId: json['customer_id'] as String,
  createdAt: json['created_at'] as String,
  urls: CustomerPortalUrls.fromJson(json['urls'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CustomerPortalSessionToJson(
  CustomerPortalSession instance,
) => <String, dynamic>{
  'id': instance.id,
  'customer_id': instance.customerId,
  'created_at': instance.createdAt,
  'urls': instance.urls,
};

CustomerPortalUrls _$CustomerPortalUrlsFromJson(
  Map<String, dynamic> json,
) => CustomerPortalUrls(
  general: GeneralPortalLinks.fromJson(json['general'] as Map<String, dynamic>),
  subscriptions:
      (json['subscriptions'] as List<dynamic>)
          .map(
            (e) => PortalSubscriptionLink.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$CustomerPortalUrlsToJson(CustomerPortalUrls instance) =>
    <String, dynamic>{
      'general': instance.general,
      'subscriptions': instance.subscriptions,
    };

GeneralPortalLinks _$GeneralPortalLinksFromJson(Map<String, dynamic> json) =>
    GeneralPortalLinks(overview: json['overview'] as String);

Map<String, dynamic> _$GeneralPortalLinksToJson(GeneralPortalLinks instance) =>
    <String, dynamic>{'overview': instance.overview};

PortalSubscriptionLink _$PortalSubscriptionLinkFromJson(
  Map<String, dynamic> json,
) => PortalSubscriptionLink(
  id: json['id'] as String,
  cancelSubscription: json['cancel_subscription'] as String,
  updateSubscriptionPaymentMethod:
      json['update_subscription_payment_method'] as String,
);

Map<String, dynamic> _$PortalSubscriptionLinkToJson(
  PortalSubscriptionLink instance,
) => <String, dynamic>{
  'id': instance.id,
  'cancel_subscription': instance.cancelSubscription,
  'update_subscription_payment_method':
      instance.updateSubscriptionPaymentMethod,
};
