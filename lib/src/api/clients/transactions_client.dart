import 'package:equatable/equatable.dart';

import '../../../paddle.dart';
import '../../model/order_by.dart';
import '../endpoints/endpoints.dart';

/// Include related entities in the transaction response.
enum TransactionInclude {
  /// Include an object for the address entity related to this transaction.
  /// Only included where an address_id is set against the transaction.
  address('address'),

  /// Include an array of adjustments related to this transaction.
  /// Only included where a transaction has adjustments.
  adjustments('adjustments'),

  /// Include an object that includes totals for all adjustments against this
  /// transaction.
  adjustmentsTotals('adjustments_totals'),

  /// Include an array of available payment methods for this transaction.
  availablePaymentMethods('available_payment_methods'),

  /// Include an object for the business entity related to this transaction.
  /// Only included where a business_id is set against the transaction.
  business('business'),

  /// Include an object for the customer entity related to this transaction.
  /// Only included where a customer_id is set against the transaction.
  customer('customer'),

  /// Include an object for the discount entity related to this transaction.
  /// Only included where a discount_id is set against the transaction.
  discount('discount');

  final String param;

  const TransactionInclude(this.param);
}

/// Valid fields for ordering: billed_at, created_at, id, and updated_at.
enum TransactionOrderField {
  billedAt('billed_at'),
  createdAt('created_at'),
  id('id'),
  updatedAt('updated_at');

  const TransactionOrderField(this.param);

  final String param;
}

/// Order returned entities by the specified field and direction
/// ([ASC] or [DESC]). For example, ?order_by=id[ASC].
final class TransactionOrderBy extends OrderBy<TransactionOrderField> {
  const TransactionOrderBy({required super.direction, required super.field});

  @override
  String get fieldParam => field.param;
}

/// Base class for items that can be charged on a transaction.
///
/// Transactions can include three types of items:
/// - [CatalogTransactionItem]: Uses an existing catalog price
/// - [NonCatalogProductTransactionItem]: Custom price for an existing product
/// - [NonCatalogCompleteTransactionItem]: Custom price and product
sealed class MiniTransactionItem with EquatableMixin {
  const MiniTransactionItem();

  /// Converts this TransactionItem to a Map that can be sent to the API
  Map<String, dynamic> toJson();
}

/// A transaction item that uses an existing catalog price.
final class CatalogTransactionItem extends MiniTransactionItem {
  /// Paddle ID of an existing catalog price to add to this transaction,
  /// prefixed with pri_.
  final String priceId;

  /// Quantity of this item on the transaction.
  final int quantity;

  const CatalogTransactionItem({required this.priceId, required this.quantity});

  @override
  Map<String, dynamic> toJson() => {'price_id': priceId, 'quantity': quantity};

  @override
  List<Object?> get props => [priceId, quantity];
}

/// A transaction item that uses a custom price for an existing product.
final class NonCatalogProductTransactionItem extends MiniTransactionItem {
  /// Price object for a non-catalog item to charge for.
  final Map<String, dynamic> price;

  /// Quantity of this item on the transaction.
  final int quantity;

  const NonCatalogProductTransactionItem({
    required this.price,
    required this.quantity,
  });

  /// Creates a non-catalog transaction item for an existing product.
  ///
  /// This factory constructs a properly formatted price object with all
  /// required fields.
  factory NonCatalogProductTransactionItem.create({
    required String description,
    required String productId,
    required UnitPrice unitPrice,
    required int quantity,
    String? name,
    Period? billingCycle,
    Period? trialPeriod,
    TaxMode? taxMode,
    List<UnitPriceOverride>? unitPriceOverrides,
    Quantity? quantityLimits,
    Map<String, dynamic>? customData,
  }) {
    return NonCatalogProductTransactionItem(
      price: {
        'description': description,
        'product_id': productId,
        'unit_price': unitPrice.toJson(),
        if (name != null) 'name': name,
        if (billingCycle != null) 'billing_cycle': billingCycle.toJson(),
        if (trialPeriod != null) 'trial_period': trialPeriod.toJson(),
        if (taxMode != null) 'tax_mode': taxMode.name,
        if (unitPriceOverrides != null)
          'unit_price_overrides':
              unitPriceOverrides.map((e) => e.toJson()).toList(),
        if (quantityLimits != null) 'quantity': quantityLimits.toJson(),
        if (customData != null) 'custom_data': customData,
      },
      quantity: quantity,
    );
  }

  @override
  Map<String, dynamic> toJson() => {'price': price, 'quantity': quantity};

  @override
  List<Object?> get props => [price, quantity];
}

/// A transaction item that uses a custom price and product.
final class NonCatalogCompleteTransactionItem extends MiniTransactionItem {
  /// Price object for a non-catalog item to charge for.
  final Map<String, dynamic> price;

  /// Quantity of this item on the transaction.
  final int quantity;

  const NonCatalogCompleteTransactionItem({
    required this.price,
    required this.quantity,
  });

  /// Creates a complete non-catalog transaction item with a custom product.
  ///
  /// This factory constructs a properly formatted price and product object
  /// with all required fields.
  factory NonCatalogCompleteTransactionItem.create({
    // Price fields
    required String description,
    required UnitPrice unitPrice,
    // Product fields
    required String productName,
    required TaxCategory taxCategory,
    required int quantity,
    // Optional price fields
    String? priceName,
    Period? billingCycle,
    Period? trialPeriod,
    TaxMode? taxMode,
    List<UnitPriceOverride>? unitPriceOverrides,
    Quantity? quantityLimits,
    Map<String, dynamic>? priceCustomData,
    // Optional product fields
    String? productDescription,
    String? imageUrl,
    Map<String, dynamic>? productCustomData,
  }) {
    return NonCatalogCompleteTransactionItem(
      price: {
        'description': description,
        'unit_price': unitPrice.toJson(),
        if (priceName != null) 'name': priceName,
        if (billingCycle != null) 'billing_cycle': billingCycle.toJson(),
        if (trialPeriod != null) 'trial_period': trialPeriod.toJson(),
        if (taxMode != null) 'tax_mode': taxMode.name,
        if (unitPriceOverrides != null)
          'unit_price_overrides':
              unitPriceOverrides.map((e) => e.toJson()).toList(),
        if (quantityLimits != null) 'quantity': quantityLimits.toJson(),
        if (priceCustomData != null) 'custom_data': priceCustomData,
        'product': {
          'name': productName,
          'tax_category': taxCategory.param,
          if (productDescription != null) 'description': productDescription,
          if (imageUrl != null) 'image_url': imageUrl,
          if (productCustomData != null) 'custom_data': productCustomData,
        },
      },
      quantity: quantity,
    );
  }

  @override
  Map<String, dynamic> toJson() => {'price': price, 'quantity': quantity};

  @override
  List<Object?> get props => [price, quantity];
}

final class TransactionsClient {
  final TransactionsApi api;

  const TransactionsClient(this.api);

  /// Returns a transaction using its ID.
  ///
  /// Use the [include] parameter to include related entities in the response.
  Future<Resource<Transaction>> getTransaction(
    String id, {
    List<TransactionInclude>? include,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (include != null) 'include': include.map((e) => e.param).toList(),
    };

    final response = await api.getTransaction(id, queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return Resource<Transaction>.fromJson(
      response.body!,
      (json) => Transaction.fromJson(json),
    );
  }

  /// Returns a paginated list of transactions.
  /// Use the query parameters to page through results.
  Future<TransactionList> listTransactions({
    String? after,
    String? billedAt,
    CollectionMode? collectionMode,
    String? createdAt,
    List<String>? customerId,
    List<String>? id,
    List<TransactionInclude>? include,
    List<String>? invoiceNumber,
    List<String>? origin,
    TransactionOrderBy? orderBy,
    List<TransactionStatus>? status,
    List<String>? subscriptionId,
    int? perPage,
    String? updatedAt,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (after != null) 'after': after,
      if (billedAt != null) 'billed_at': billedAt,
      if (collectionMode != null) 'collection_mode': collectionMode.name,
      if (createdAt != null) 'created_at': createdAt,
      if (customerId != null) 'customer_id': customerId,
      if (id != null) 'id': id,
      if (include != null) 'include': include.map((e) => e.param).toList(),
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (origin != null) 'origin': origin,
      if (orderBy != null) ...orderBy.toQueryParams(),
      if (status != null) 'status': status.map((e) => e.name).toList(),
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (perPage != null) 'per_page': perPage,
      if (updatedAt != null) 'updated_at': updatedAt,
    };

    final response = await api.listTransactions(queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }
    return TransactionList.fromJson(response.body!);
  }

  /// Creates a new transaction.
  ///
  /// Transactions are typically created with the status of draft or ready
  /// initially.
  Future<Resource<Transaction>> createTransaction({
    required List<MiniTransactionItem> items,
    TransactionStatus? status,
    String? customerId,
    String? addressId,
    String? businessId,
    Map<String, dynamic>? customData,
    String? currencyCode,
    CollectionMode? collectionMode,
    String? discountId,
    BillingDetails? billingDetails,
    BillingPeriod? billingPeriod,
    Checkout? checkout,
    List<TransactionInclude>? include,
  }) async {
    final Map<String, dynamic> body = {
      'items': items.map((item) => item.toJson()).toList(),
      if (status != null) 'status': status.name,
      if (customerId != null) 'customer_id': customerId,
      if (addressId != null) 'address_id': addressId,
      if (businessId != null) 'business_id': businessId,
      if (customData != null) 'custom_data': customData,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (collectionMode != null) 'collection_mode': collectionMode.name,
      if (discountId != null) 'discount_id': discountId,
      if (billingDetails != null) 'billing_details': billingDetails.toJson(),
      if (billingPeriod != null) 'billing_period': billingPeriod.toJson(),
      if (checkout != null) 'checkout': checkout,
    };

    final Map<String, dynamic> queryParams = {
      if (include != null) 'include': include.map((e) => e.param).toList(),
    };

    final response = await api.createTransaction(body, queryParams);
    if (!response.isSuccessful) {
      throw PaddleApiError.fromJson(
        Map<String, dynamic>.from(response.error as Map),
      );
    }

    return Resource<Transaction>.fromJson(
      response.body!,
      (json) => Transaction.fromJson(json),
    );
  }
}
