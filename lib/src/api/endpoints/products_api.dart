import 'package:chopper/chopper.dart';

import '../../utils.dart';

part 'products_api.chopper.dart';

@ChopperApi()
abstract class ProductsApi extends ChopperService {
  ProductsApi();

  factory ProductsApi.create([ChopperClient? client]) => _$ProductsApi(client);

  @GET(path: '/products/{id}')
  Future<Response<JsonMap>> getProduct(
    @Path('id') String id, [
    @QueryMap() Map<String, dynamic>? params,
  ]);

  @GET(path: '/products')
  Future<Response<JsonMap>> listProducts([
    @QueryMap() Map<String, dynamic>? params,
  ]);
}
