// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscriptions_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SubscriptionsApi extends SubscriptionsApi {
  _$SubscriptionsApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SubscriptionsApi;

  @override
  Future<Response<Map<String, dynamic>>> getSubscription(
    String id, [
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse('/subscriptions/${id}');
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
  Future<Response<Map<String, dynamic>>> listSubscriptions([
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse('/subscriptions');
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
  Future<Response<Map<String, dynamic>>> updateSubscription(
    String id, [
    Map<String, dynamic>? body,
  ]) {
    final Uri $url = Uri.parse('/subscriptions/${id}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> cancelSubscription(
    String id, [
    Map<String, dynamic>? body,
  ]) {
    final Uri $url = Uri.parse('/subscriptions/${id}/cancel');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
