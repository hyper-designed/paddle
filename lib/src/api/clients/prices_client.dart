import '../../model/entity_status.dart';
import '../../model/models.dart';
import '../../model/order_by.dart';
import '../endpoints/prices_api.dart';

enum PriceInclude { product }

/// Valid fields for ordering: billing_cycle.frequency, billing_cycle.interval,
/// id, product_id, quantity.maximum, quantity.minimum, status, tax_mode,
/// unit_price.amount, and unit_price.currency_code.
enum PriceOrderField {
  billingCycleFrequency('billing_cycle.frequency'),
  billingCycleInterval('billing_cycle.interval'),
  id('id'),
  productId('product_id'),
  quantityMaximum('quantity.maximum'),
  quantityMinimum('quantity.minimum'),
  status('status'),
  taxMode('tax_mode'),
  unitPriceAmount('unit_price.amount'),
  unitPriceCurrencyCode('unit_price.currency_code');

  const PriceOrderField(this.param);

  final String param;
}

/// Order returned entities by the specified field and direction
/// ([ASC] or [DESC]). For example, ?order_by=id[ASC].
final class PriceOrderBy extends OrderBy<PriceOrderField> {
  const PriceOrderBy({required super.direction, required super.field});

  @override
  String get fieldParam => field.param;
}

final class PricesClient {
  final PricesApi api;

  PricesClient(this.api);

  Future<Resource<Price>> getPrice(
    String id, {
    List<PriceInclude>? include,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (include != null) 'include': include.map((e) => e.name).toList(),
    };

    final response = await api.getPrice(id, queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(response.body!);
    }
    return Resource<Price>.fromJson(
      response.body!,
      (json) => Price.fromJson(json),
    );
  }

  Future<PriceList> listPrices({
    String? after,
    List<String>? id,
    List<PriceInclude>? include,
    PriceOrderBy? orderBy,
    int? perPage,
    List<String>? productId,
    EntityStatus? status,
    bool? recurring,
    ProductType? type,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (after != null) 'after': after,
      if (id != null) 'id': id,
      if (include != null) 'include': include.map((e) => e.name).toList(),
      if (orderBy != null) ...orderBy.toQueryParams(),
      if (perPage != null) 'per_page': perPage,
      if (productId != null) 'product_id': productId,
      if (status != null) 'status': status.name,
      if (recurring != null) 'recurring': recurring,
      if (type != null) 'type': type.name,
    };
    final response = await api.listPrices(queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(response.body!);
    }
    return PriceList.fromJson(response.body!);
  }
}
