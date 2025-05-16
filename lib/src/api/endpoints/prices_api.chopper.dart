// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prices_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$PricesApi extends PricesApi {
  _$PricesApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = PricesApi;

  @override
  Future<Response<Map<String, dynamic>>> getPrice(
    String priceId, [
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse('/prices/${priceId}');
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
  Future<Response<Map<String, dynamic>>> listPrices([
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse('/prices');
    final Map<String, dynamic> $params = params ?? const {};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
