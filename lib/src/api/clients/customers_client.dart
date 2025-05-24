import '../../model/models.dart';
import '../../model/order_by.dart';
import '../endpoints/customers_api.dart';

/// Valid fields for ordering: id.
enum CustomerOrderField {
  id('id');

  const CustomerOrderField(this.param);

  final String param;
}

/// Order returned entities by the specified field and direction
/// ([ASC] or [DESC]). For example, ?order_by=id[ASC].
final class CustomerOrderBy extends OrderBy<CustomerOrderField> {
  const CustomerOrderBy({required super.direction, required super.field});

  @override
  String get fieldParam => field.param;
}

final class CustomersClient {
  final CustomersApi api;

  const CustomersClient(this.api);

  Future<Resource<Customer>> getCustomer(String id) async {
    final response = await api.getCustomer(id);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return Resource<Customer>.fromJson(
      response.body!,
      (json) => Customer.fromJson(json),
    );
  }

  Future<CustomerList> listCustomers({
    String? after,
    List<String>? email,
    List<String>? id,
    CustomerOrderBy? orderBy,
    int? perPage,
    String? search,
    List<EntityStatus>? status,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (after != null) 'after': after,
      if (email != null) 'email': email,
      if (id != null) 'id': id,
      if (orderBy != null) 'order_by': orderBy.toString(),
      if (perPage != null) 'per_page': perPage,
      if (search != null) 'search': search,
      if (status != null) 'status': status.map((e) => e.name).toList(),
    };

    final response = await api.listCustomers(queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return CustomerList.fromJson(response.body!);
  }

  Future<CustomerPortalSession> createCustomerPortalSession(
    String customerId, {
    List<String>? subscriptionIds,
  }) async {
    final Map<String, dynamic> body = {
      if (subscriptionIds != null) 'subscription_ids': subscriptionIds,
    };

    final response = await api.createCustomerPortalSession(customerId, body);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return CustomerPortalSession.fromJson(response.body!);
  }
}
