import 'package:chopper/chopper.dart';

import '../../utils.dart';

part 'transactions_api.chopper.dart';

@ChopperApi()
abstract class TransactionsApi extends ChopperService {
  TransactionsApi();

  factory TransactionsApi.create([ChopperClient? client]) =>
      _$TransactionsApi(client);

  @GET(path: '/transactions/{transaction_id}')
  Future<Response<JsonMap>> getTransaction(
    @Path('transaction_id') String id, [
    @QueryMap() Map<String, dynamic>? params,
  ]);

  @GET(path: '/transactions')
  Future<Response<JsonMap>> listTransactions([
    @QueryMap() Map<String, dynamic>? params,
  ]);

  @POST(path: '/transactions')
  Future<Response<JsonMap>> createTransaction(
    @Body() Map<String, dynamic> body, [
    @QueryMap() Map<String, dynamic>? params,
  ]);
}
