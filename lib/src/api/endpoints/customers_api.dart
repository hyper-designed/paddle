import 'package:chopper/chopper.dart';

import '../../utils.dart';

part 'customers_api.chopper.dart';

@ChopperApi()
abstract class CustomersApi extends ChopperService {
  CustomersApi();

  factory CustomersApi.create([ChopperClient? client]) =>
      _$CustomersApi(client);

  @GET(path: '/customers/{id}')
  Future<Response<JsonMap>> getCustomer(
    @Path('id') String priceId, [
    @QueryMap() Map<String, dynamic>? params,
  ]);

  @GET(path: '/customers')
  Future<Response<JsonMap>> listCustomers([
    @QueryMap() Map<String, dynamic>? params,
  ]);

  /// Creates a new customer.
  ///
  /// If successful, your response includes a copy of the new customer entity.
  @POST(path: '/customers')
  Future<Response<JsonMap>> createCustomer(@Body() Map<String, dynamic> body);

  /// Creates a customer portal session for a customer.
  ///
  /// The customer portal is a secure, Paddle-hosted site that allows customers
  /// to manage their own subscriptions, payments, and account information
  /// without you having to build custom billing screens.
  ///
  /// Customers can:
  ///
  /// View transaction history
  /// Download invoices
  /// Update payment methods
  /// Manage their subscriptions including making changes or cancellations
  /// Revise details on completed transactions
  ///
  /// You can create a customer portal session to generate authenticated links
  /// for a customer so that they're automatically signed in to the portal.
  /// It's typically used when linking to the customer portal from your
  /// app where customers are already authenticated.
  ///
  /// You can include an array of subscription_ids to generate authenticated
  /// portal links that let customers make changes to their subscriptions.
  /// You can use these links as part of subscription management workflows
  /// rather than building your own billing screens.
  ///
  /// Customer portal sessions are temporary and shouldn't be cached.
  ///
  /// The customer portal is fully hosted by Paddle. For security and the best
  /// customer experience, don't embed the customer portal in an iframe.
  @POST(path: '/customers/{customer_id}/portal-sessions')
  Future<Response<JsonMap>> createCustomerPortalSession(
    @Path('customer_id') String customerId, [
    @Body() Map<String, dynamic>? body,
  ]);
}
