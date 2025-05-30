import '../../model/models.dart';
import '../../model/order_by.dart';
import '../endpoints/endpoints.dart';

enum EffectiveFrom {
  immediately('immediately'),
  nextBillingPeriod('next_billing_period');

  const EffectiveFrom(this.param);

  final String param;
}

enum SubscriptionInclude {
  nextTransaction('next_transaction'),
  recurringTransactionDetails('recurring_transaction_details');

  const SubscriptionInclude(this.param);

  final String param;
}

/// How Paddle should handle proration calculation for changes made to a
/// subscription or its items. Required when making changes that impact billing.
enum ProrationBillingMode {
  /// Paddle calculates the prorated amount for the subscription changes based
  /// on the current billing cycle, then creates a transaction to collect
  /// immediately.
  proratedImmediately('prorated_immediately'),

  /// Paddle calculates the prorated amount for the subscription changes based
  /// on the current billing cycle, then schedules them to be billed on the
  /// next renewal.
  proratedNextBillingPeriod('prorated_next_billing_period'),

  /// Paddle does not calculate proration for the subscription changes,
  /// creating a transaction to collect for the full amount immediately.
  fullImmediately('full_immediately'),

  /// Paddle does not calculate proration for the subscription changes,
  /// scheduling for the full amount for the changes to be billed on the
  /// next renewal.
  fullNextBillingPeriod('full_next_billing_period'),

  /// Paddle does not bill for the subscription changes.
  doNotBill('do_not_bill');

  const ProrationBillingMode(this.param);

  final String param;
}

/// How Paddle should handle changes made to a subscription or its items if the
/// payment fails during update.
enum OnPaymentFailure {
  /// In case of payment failure, prevent the change to the subscription from
  /// applying.
  preventChange('prevent_change'),

  /// In case of payment failure, apply the change and update the subscription.
  applyChange('apply_change');

  const OnPaymentFailure(this.param);

  final String param;
}

/// Details of the discount to be applied to a subscription during updates.
final class SubscriptionDiscount {
  /// Unique Paddle ID for this discount, prefixed with dsc_.
  final String id;

  /// When this discount should take effect from.
  final EffectiveFrom effectiveFrom;

  const SubscriptionDiscount({required this.id, required this.effectiveFrom});

  Map<String, dynamic> toJson() => {
    'id': id,
    'effective_from': effectiveFrom.param,
  };
}

/// Valid fields for ordering: id.
enum SubscriptionOrderField {
  id('id');

  const SubscriptionOrderField(this.param);

  final String param;
}

/// Order returned entities by the specified field and direction
/// ([ASC] or [DESC]). For example, ?order_by=id[ASC].
final class SubscriptionOrderBy extends OrderBy<SubscriptionOrderField> {
  const SubscriptionOrderBy({required super.direction, required super.field});

  @override
  String get fieldParam => field.param;
}

/// Base class for items that can be added/updated on a subscription.
sealed class SubscriptionItem {
  const SubscriptionItem();

  /// Converts this SubscriptionItem to a Map that can be sent to the API
  Map<String, dynamic> toJson();
}

/// A subscription item that uses an existing catalog price.
final class CatalogSubscriptionItem extends SubscriptionItem {
  /// Paddle ID for the price to add to this subscription, prefixed with pri_.
  final String priceId;

  /// Quantity of this item to add to the subscription. If updating an existing
  /// item and not changing the quantity, you may omit quantity.
  final int? quantity;

  const CatalogSubscriptionItem({required this.priceId, this.quantity});

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{'price_id': priceId};
    if (quantity != null) {
      json['quantity'] = quantity;
    }
    return json;
  }
}

/// A subscription item that uses a custom price for an existing product.
final class NonCatalogProductSubscriptionItem extends SubscriptionItem {
  /// Price object for a non-catalog item to charge for.
  final Map<String, dynamic> price;

  /// Quantity of this item to add to the subscription. If updating an existing
  /// item and not changing the quantity, you may omit quantity.
  final int? quantity;

  const NonCatalogProductSubscriptionItem({required this.price, this.quantity});

  /// Creates a non-catalog subscription item for an existing product.
  factory NonCatalogProductSubscriptionItem.create({
    required String description,
    required String productId,
    required UnitPrice unitPrice,
    int? quantity,
    String? name,
    Period? billingCycle,
    Period? trialPeriod,
    TaxMode? taxMode,
    List<UnitPriceOverride>? unitPriceOverrides,
    Quantity? quantityLimits,
    Map<String, dynamic>? customData,
  }) {
    return NonCatalogProductSubscriptionItem(
      price: {
        'description': description,
        'product_id': productId,
        'unit_price': unitPrice.toJson(),
        if (name != null) 'name': name,
        if (billingCycle != null) 'billing_cycle': billingCycle.toJson(),
        if (trialPeriod != null) 'trial_period': trialPeriod.toJson(),
        if (taxMode != null) 'tax_mode': taxMode.name,
        if (unitPriceOverrides != null)
          'unit_price_overrides':
              unitPriceOverrides.map((e) => e.toJson()).toList(),
        if (quantityLimits != null) 'quantity': quantityLimits.toJson(),
        if (customData != null) 'custom_data': customData,
      },
      quantity: quantity,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{'price': price};
    if (quantity != null) {
      json['quantity'] = quantity;
    }
    return json;
  }
}

/// A subscription item that uses a custom price and product.
final class NonCatalogCompleteSubscriptionItem extends SubscriptionItem {
  /// Price object for a non-catalog item to charge for.
  final Map<String, dynamic> price;

  /// Quantity of this item to add to the subscription. If updating an existing
  /// item and not changing the quantity, you may omit quantity.
  final int? quantity;

  const NonCatalogCompleteSubscriptionItem({
    required this.price,
    this.quantity,
  });

  /// Creates a complete non-catalog subscription item with a custom product.
  factory NonCatalogCompleteSubscriptionItem.create({
    // Price fields
    required String description,
    required UnitPrice unitPrice,
    // Product fields
    required String productName,
    required TaxCategory taxCategory,
    int? quantity,
    // Optional price fields
    String? priceName,
    Period? billingCycle,
    Period? trialPeriod,
    TaxMode? taxMode,
    List<UnitPriceOverride>? unitPriceOverrides,
    Quantity? quantityLimits,
    Map<String, dynamic>? priceCustomData,
    // Optional product fields
    String? productDescription,
    String? imageUrl,
    Map<String, dynamic>? productCustomData,
  }) {
    return NonCatalogCompleteSubscriptionItem(
      price: {
        'description': description,
        'unit_price': unitPrice.toJson(),
        if (priceName != null) 'name': priceName,
        if (billingCycle != null) 'billing_cycle': billingCycle.toJson(),
        if (trialPeriod != null) 'trial_period': trialPeriod.toJson(),
        if (taxMode != null) 'tax_mode': taxMode.name,
        if (unitPriceOverrides != null)
          'unit_price_overrides':
              unitPriceOverrides.map((e) => e.toJson()).toList(),
        if (quantityLimits != null) 'quantity': quantityLimits.toJson(),
        if (priceCustomData != null) 'custom_data': priceCustomData,
        'product': {
          'name': productName,
          'tax_category': taxCategory.param,
          if (productDescription != null) 'description': productDescription,
          if (imageUrl != null) 'image_url': imageUrl,
          if (productCustomData != null) 'custom_data': productCustomData,
        },
      },
      quantity: quantity,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{'price': price};
    if (quantity != null) {
      json['quantity'] = quantity;
    }
    return json;
  }
}

final class SubscriptionsClient {
  final SubscriptionsApi api;

  const SubscriptionsClient(this.api);

  Future<Resource<Subscription>> getSubscription(
    String id, {
    List<SubscriptionInclude>? include,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (include != null) 'include': include.map((e) => e.param).toList(),
    };

    final response = await api.getSubscription(id, queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return Resource<Subscription>.fromJson(
      response.body!,
      (json) => Subscription.fromJson(json),
    );
  }

  Future<SubscriptionList> listSubscriptions({
    List<String>? addressId,
    String? after,
    CollectionMode? collectionMode,
    List<String>? customerId,
    List<String>? id,
    SubscriptionOrderBy? orderBy,
    int? perPage,
    List<String>? priceId,
    List<ScheduledChangeAction>? scheduledChangeAction,
    EntityStatus? status,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (addressId != null) 'address_id': addressId,
      if (after != null) 'after': after,
      if (collectionMode != null) 'collection_mode': collectionMode.name,
      if (customerId != null) 'customer_id': customerId,
      if (id != null) 'id': id,
      if (orderBy != null) 'order_by': orderBy.toString(),
      if (perPage != null) 'per_page': perPage,
      if (priceId != null) 'price_id': priceId,
      if (scheduledChangeAction != null)
        'scheduled_change_action':
            scheduledChangeAction.map((e) => e.name).toList(),
      if (status != null) 'status': status.name,
    };

    final response = await api.listSubscriptions(queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return SubscriptionList.fromJson(response.body!);
  }

  /// Updates a subscription using its ID.
  ///
  /// When making changes to items or the next billing date for a subscription,
  /// you must include the [prorationBillingMode] field to tell Paddle how to
  /// bill for those changes.
  ///
  /// Send the complete list of [items] that you'd like to be on a
  /// subscription — including existing items. If you omit items, they're
  /// removed from the subscription.
  ///
  /// For each item, send price_id and quantity. Paddle responds with the full
  /// price object for each price. If you're updating an existing item, you can
  /// omit the quantity if you don't want to update it.
  ///
  /// If successful, your response includes a copy of the updated subscription
  /// entity. When an update results in an immediate charge, responses may take
  /// longer than usual while a payment attempt is processed.
  Future<Resource<Subscription>> updateSubscription(
    String id, {
    String? customerId,
    String? addressId,
    String? businessId,
    String? currencyCode,
    DateTime? nextBilledAt,
    SubscriptionDiscount? discount,
    CollectionMode? collectionMode,
    BillingDetails? billingDetails,
    List<SubscriptionItem>? items,
    Map<String, dynamic>? customData,
    ProrationBillingMode? prorationBillingMode,
    OnPaymentFailure? onPaymentFailure,
  }) async {
    final Map<String, dynamic> body = {
      if (customerId != null) 'customer_id': customerId,
      if (addressId != null) 'address_id': addressId,
      if (businessId != null) 'business_id': businessId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (nextBilledAt != null)
        'next_billed_at': nextBilledAt.toIso8601String(),
      if (discount != null) 'discount': discount.toJson(),
      if (collectionMode != null) 'collection_mode': collectionMode.name,
      if (billingDetails != null) 'billing_details': billingDetails.toJson(),
      // Set scheduled_change to null to remove scheduled changes as per API docs
      'scheduled_change': null,
      if (items != null) 'items': items.map((item) => item.toJson()).toList(),
      if (customData != null) 'custom_data': customData,
      if (prorationBillingMode != null)
        'proration_billing_mode': prorationBillingMode.param,
      if (onPaymentFailure != null)
        'on_payment_failure': onPaymentFailure.param,
    };

    final response = await api.updateSubscription(id, body);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }

    return Resource<Subscription>.fromJson(
      response.body!,
      (json) => Subscription.fromJson(json),
    );
  }

  Future<Resource<Product>> cancelSubscription(
    String id, {
    EffectiveFrom? effectiveFrom,
  }) async {
    final Map<String, dynamic> body = {
      if (effectiveFrom != null) 'effective_from': effectiveFrom.param,
    };

    final response = await api.cancelSubscription(id, body);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }

    return Resource<Product>.fromJson(
      response.body!,
      (json) => Product.fromJson(json),
    );
  }
}
