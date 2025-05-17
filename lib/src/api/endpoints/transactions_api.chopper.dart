// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$TransactionsApi extends TransactionsApi {
  _$TransactionsApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = TransactionsApi;

  @override
  Future<Response<Map<String, dynamic>>> getTransaction(
    String id, [
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse('/transactions/${id}');
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
  Future<Response<Map<String, dynamic>>> listTransactions([
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse('/transactions');
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
  Future<Response<Map<String, dynamic>>> createTransaction(
    Map<String, dynamic> body, [
    Map<String, dynamic>? params,
  ]) {
    final Uri $url = Uri.parse('/transactions');
    final Map<String, dynamic> $params = params ?? const {};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
