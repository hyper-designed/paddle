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
