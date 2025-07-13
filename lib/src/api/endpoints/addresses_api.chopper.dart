// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addresses_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AddressesApi extends AddressesApi {
  _$AddressesApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AddressesApi;

  @override
  Future<Response<Map<String, dynamic>>> getAddress(
    String customerId,
    String addressId, [
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse(
      '/customers/${customerId}/addresses/${addressId}',
    );
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
  Future<Response<Map<String, dynamic>>> listAddresses(
    String customerId, [
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse('/customers/${customerId}/addresses');
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
  Future<Response<Map<String, dynamic>>> createAddress(
    String customerId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/customers/${customerId}/addresses');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> updateAddress(
    String customerId,
    String addressId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse(
      '/customers/${customerId}/addresses/${addressId}',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
