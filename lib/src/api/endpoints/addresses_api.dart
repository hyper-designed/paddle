import 'package:chopper/chopper.dart';

import '../../utils.dart';

part 'addresses_api.chopper.dart';

@ChopperApi()
abstract class AddressesApi extends ChopperService {
  AddressesApi();

  factory AddressesApi.create([ChopperClient? client]) =>
      _$AddressesApi(client);

  /// Returns an address for a customer using its ID and related customer ID.
  @GET(path: '/customers/{customer_id}/addresses/{address_id}')
  Future<Response<JsonMap>> getAddress(
    @Path('customer_id') String customerId,
    @Path('address_id') String addressId, [
    @QueryMap() Map<String, dynamic>? params,
  ]);

  /// Returns a paginated list of addresses for a customer.
  /// Use the query parameters to page through results.
  ///
  /// By default, Paddle returns addresses that are active.
  /// Use the status query parameter to return addresses that are archived.
  @GET(path: '/customers/{customer_id}/addresses')
  Future<Response<JsonMap>> listAddresses(
    @Path('customer_id') String customerId, [
    @QueryMap() Map<String, dynamic>? params,
  ]);

  /// Creates a new address for a customer.
  ///
  /// For tax calculation, fraud prevention, and compliance purposes, you must
  /// include a postal_code when creating addresses for some countries.
  /// For example, ZIP codes in the USA and postcodes in the UK.
  ///
  /// If successful, your response includes a copy of the new address entity.
  @POST(path: '/customers/{customer_id}/addresses')
  Future<Response<JsonMap>> createAddress(
    @Path('customer_id') String customerId,
    @Body() Map<String, dynamic> body,
  );

  /// Updates an address for a customer using its ID and related customer ID.
  ///
  /// If successful, your response includes a copy of the updated address
  /// entity.
  @PATCH(path: '/customers/{customer_id}/addresses/{address_id}')
  Future<Response<JsonMap>> updateAddress(
    @Path('customer_id') String customerId,
    @Path('address_id') String addressId,
    @Body() Map<String, dynamic> body,
  );
}
