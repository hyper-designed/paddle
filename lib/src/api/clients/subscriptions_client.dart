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

final class SubscriptionsClient {
  final SubscriptionsApi api;

  SubscriptionsClient(this.api);

  Future<Resource<Subscription>> getSubscription(
    String id, {
    List<SubscriptionInclude>? include,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (include != null) 'include': include.map((e) => e.name).toList(),
    };

    final response = await api.getSubscription(id, queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(response.body!);
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
      throw PaddleApiError.fromJson(response.body!);
    }
    return SubscriptionList.fromJson(response.body!);
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
      throw PaddleApiError.fromJson(response.body!);
    }

    return Resource<Product>.fromJson(
      response.body!,
      (json) => Product.fromJson(json),
    );
  }
}
