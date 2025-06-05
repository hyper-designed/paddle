// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$CustomersApi extends CustomersApi {
  _$CustomersApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = CustomersApi;

  @override
  Future<Response<Map<String, dynamic>>> getCustomer(
    String priceId, [
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse('/customers/${priceId}');
    final Map<String, dynamic> $params = params ?? const {};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> listCustomers([
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse('/customers');
    final Map<String, dynamic> $params = params ?? const {};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> createCustomer(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/customers');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> createCustomerPortalSession(
    String customerId, [
    Map<String, dynamic>? body,
  ]) {
    final Uri $url = Uri.parse('/customers/${customerId}/portal-sessions');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
