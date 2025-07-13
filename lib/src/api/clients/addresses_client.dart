import '../../model/models.dart';
import '../../model/order_by.dart';
import '../endpoints/addresses_api.dart';

/// Valid fields for ordering: id.
enum AddressOrderField {
  id('id');

  const AddressOrderField(this.param);

  final String param;
}

/// Order returned entities by the specified field and direction
/// ([ASC] or [DESC]).
/// For example, ?order_by=id[ASC].
final class AddressOrderBy extends OrderBy<AddressOrderField> {
  const AddressOrderBy({required super.direction, required super.field});

  @override
  String get fieldParam =>
      '${field.param}[${switch (direction) {
        SortDirection.ascending => 'ASC',
        SortDirection.descending => 'DESC',
      }}]';
}

final class AddressesClient {
  final AddressesApi api;

  const AddressesClient(this.api);

  /// Returns an address for a customer using its ID and related customer ID.
  Future<Resource<Address>> getAddress({
    required String customerId,
    required String addressId,
  }) async {
    final response = await api.getAddress(customerId, addressId);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return Resource<Address>.fromJson(
      response.body!,
      (json) => Address.fromJson(json),
    );
  }

  /// Returns a paginated list of addresses for a customer.
  /// Use the query parameters to page through results.
  ///
  /// By default, Paddle returns addresses that are active.
  /// Use the status query parameter to return addresses that are archived.
  Future<AddressList> listAddresses({
    required String customerId,
    String? after,
    List<String>? id,
    AddressOrderBy? orderBy,
    int? perPage,
    String? search,
    List<EntityStatus>? status,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (after != null) 'after': after,
      if (id != null) 'id': id,
      if (orderBy != null) 'order_by': orderBy.fieldParam,
      if (perPage != null) 'per_page': perPage,
      if (search != null) 'search': search,
      if (status != null) 'status': status.map((e) => e.name).toList(),
    };

    final response = await api.listAddresses(customerId, queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return AddressList.fromJson(response.body!);
  }

  /// Creates a new address for a customer.
  ///
  /// For tax calculation, fraud prevention, and compliance purposes, you must
  /// include a postal_code when creating addresses for some countries.
  /// For example, ZIP codes in the USA and postcodes in the UK.
  /// See: Supported countries
  ///
  /// If successful, your response includes a copy of the new address entity.
  Future<Resource<Address>> createAddress({
    required String customerId,
    required String countryCode,
    String? description,
    String? firstLine,
    String? secondLine,
    String? city,
    String? postalCode,
    String? region,
    Map<String, dynamic>? customData,
  }) async {
    final Map<String, dynamic> body = {
      'country_code': countryCode,
      if (description != null) 'description': description,
      if (firstLine != null) 'first_line': firstLine,
      if (secondLine != null) 'second_line': secondLine,
      if (city != null) 'city': city,
      if (postalCode != null) 'postal_code': postalCode,
      if (region != null) 'region': region,
      if (customData != null) 'custom_data': customData,
    };

    final response = await api.createAddress(customerId, body);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return Resource<Address>.fromJson(
      response.body!,
      (json) => Address.fromJson(json),
    );
  }

  /// Updates an address using its ID.
  ///
  /// If successful, your response includes a copy of the updated address entity.
  Future<Resource<Address>> updateAddress({
    required String customerId,
    required String addressId,
    String? description,
    String? firstLine,
    String? secondLine,
    String? city,
    String? postalCode,
    String? region,
    String? countryCode,
    Map<String, dynamic>? customData,
  }) async {
    final Map<String, dynamic> body = {
      if (description != null) 'description': description,
      if (firstLine != null) 'first_line': firstLine,
      if (secondLine != null) 'second_line': secondLine,
      if (city != null) 'city': city,
      if (postalCode != null) 'postal_code': postalCode,
      if (region != null) 'region': region,
      if (countryCode != null) 'country_code': countryCode,
      if (customData != null) 'custom_data': customData,
    };

    final response = await api.updateAddress(customerId, addressId, body);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return Resource<Address>.fromJson(
      response.body!,
      (json) => Address.fromJson(json),
    );
  }
}
