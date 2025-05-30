import 'package:chopper/chopper.dart';

import '../../utils.dart';

part 'subscriptions_api.chopper.dart';

@ChopperApi()
abstract class SubscriptionsApi extends ChopperService {
  SubscriptionsApi();

  factory SubscriptionsApi.create([ChopperClient? client]) =>
      _$SubscriptionsApi(client);

  @GET(path: '/subscriptions/{subscription_id}')
  Future<Response<JsonMap>> getSubscription(
    @Path('subscription_id') String id, [
    @QueryMap() Map<String, dynamic>? params,
  ]);

  @GET(path: '/subscriptions')
  Future<Response<JsonMap>> listSubscriptions([
    @QueryMap() Map<String, dynamic>? params,
  ]);

  /// Updates a subscription using its ID.
  ///
  /// When making changes to items or the next billing date for a subscription,
  /// you must include the proration_billing_mode field to tell Paddle how to
  /// bill for those changes.
  ///
  /// Send the complete list of items that you'd like to be on a
  /// subscription — including existing items.
  /// If you omit items, they're removed from the subscription.
  ///
  /// For each item, send price_id and quantity.
  /// Paddle responds with the full price object for each price.
  /// If you're updating an existing item, you can omit the quantity if
  /// you don't want to update it.
  ///
  /// If successful, your response includes a copy of the updated subscription
  /// entity.
  /// When an update results in an immediate charge, responses may take longer
  /// than usual while a payment attempt is processed.
  @PATCH(path: '/subscriptions/{subscription_id}')
  Future<Response<JsonMap>> updateSubscription(
    @Path('subscription_id') String id, [
    @Body() Map<String, dynamic>? body,
  ]);

  /// Cancels a subscription using its ID.
  ///
  /// By default, active subscriptions are canceled at the end of the billing
  /// period.
  /// When you send a request to cancel, Paddle creates a scheduled_change
  /// against the subscription entity to say that it should cancel at the end
  /// of the current billing period. Its status remains active until after the
  /// effective date of the scheduled change, at which point it changes to
  /// canceled.
  ///
  /// You can cancel a subscription right away by including effective_from in
  /// your request, setting the value to immediately.
  /// If successful, your response includes a copy of the updated subscription
  /// entity with the status of canceled. Canceling immediately is the default
  /// behavior for paused subscriptions.
  ///
  /// You can't reinstate a canceled subscription.
  @POST(path: '/subscriptions/{subscription_id}/cancel')
  Future<Response<JsonMap>> cancelSubscription(
    @Path('subscription_id') String id, [
    @Body() Map<String, dynamic>? body,
  ]);
}
