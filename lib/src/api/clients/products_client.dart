import '../../model/models.dart';
import '../../model/order_by.dart';
import '../endpoints/endpoints.dart';

enum ProductInclude { prices }

/// Valid fields for ordering: created_at, custom_data, description, id,
/// image_url, name, status, tax_category, and updated_at.
enum ProductOrderField {
  createdAt('created_at'),
  customData('custom_data'),
  description('description'),
  id('id'),
  imageUrl('image_url'),
  name('name'),
  status('status'),
  taxCategory('tax_category'),
  updatedAt('updated_at');

  const ProductOrderField(this.param);

  final String param;
}

/// Order returned entities by the specified field and direction
/// ([ASC] or [DESC]). For example, ?order_by=id[ASC].
final class ProductOrderBy extends OrderBy<ProductOrderField> {
  const ProductOrderBy({required super.direction, required super.field});

  @override
  String get fieldParam => field.param;
}

final class ProductsClient {
  final ProductsApi api;

  const ProductsClient(this.api);

  Future<Resource<Product>> getProduct(
    String id, {
    List<ProductInclude>? include,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (include != null) 'include': include.map((e) => e.name).toList(),
    };

    final response = await api.getProduct(id, queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return Resource<Product>.fromJson(
      response.body!,
      (json) => Product.fromJson(json),
    );
  }

  Future<ProductList> listProducts({
    String? after,
    List<String>? id,
    List<ProductInclude>? include,
    ProductOrderBy? orderBy,
    int? perPage,
    EntityStatus? status,
    TaxCategory? taxCategory,
    ProductType? type,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (after != null) 'after': after,
      if (id != null) 'id': id,
      if (include != null) 'include': include.map((e) => e.name).toList(),
      if (orderBy != null) ...orderBy.toQueryParams(),
      if (perPage != null) 'per_page': perPage,
      if (status != null) 'status': status.name,
      if (taxCategory != null) 'tax_category': taxCategory.param,
      if (type != null) 'type': type.name,
    };
    final response = await api.listProducts(queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return ProductList.fromJson(response.body!);
  }
}
