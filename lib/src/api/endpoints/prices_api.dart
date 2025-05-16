import 'package:chopper/chopper.dart';

import '../../utils.dart';

part 'prices_api.chopper.dart';

@ChopperApi()
abstract class PricesApi extends ChopperService {
  PricesApi();

  factory PricesApi.create([ChopperClient? client]) => _$PricesApi(client);

  @GET(path: '/prices/{id}')
  Future<Response<JsonMap>> getPrice(
    @Path('id') String priceId, [
    @QueryMap() Map<String, dynamic>? params,
  ]);

  @GET(path: '/prices')
  Future<Response<JsonMap>> listPrices([
    @QueryMap() Map<String, dynamic>? params,
  ]);
}
