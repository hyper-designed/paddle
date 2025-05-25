import 'package:paddle/paddle.dart';
import 'package:test/test.dart';

import 'env.dart';

void main() {
  late PaddleClient client;

  setUp(() {
    if (apiKey == null) {
      fail(
        'PADDLE_API_KEY environment variable not set. Please set it to run this test.',
      );
    }

    // Initialize the Paddle client with sandbox mode
    client = PaddleClient(apiKey: apiKey!, sandbox: true, enableLogging: true);
  });

  group('ProductsClient', () {
    test('listProducts returns a list of products', () async {
      // Call the API to list products
      final result = await client.products.listProducts();

      // Verify the result
      expect(result, isA<ProductList>());

      // Print some info about the returned products
      print('Number of products: ${result.data.length}');

      if (result.data.isNotEmpty) {
        final product = result.data.first;
        print('First product:');
        print('  ID: ${product.id}');
        print('  Name: ${product.name}');
        print('  Status: ${product.status}');
        print('  Type: ${product.type}');
        print('  Tax Category: ${product.taxCategory}');
      }
    });

    test(
      'listProducts with include parameter returns products & prices',
      () async {
        // Call the API to list products with prices included
        final result = await client.products.listProducts(
          include: [ProductInclude.prices],
        );

        // Verify the result
        expect(result, isA<ProductList>());

        // Print some info about the returned products
        print('Number of products: ${result.data.length}');

        expect(result.data, isNotEmpty);

        final product = result.data.first;
        print('First product:');
        print('  ID: ${product.id}');
        print('  Name: ${product.name}');
        print('  Status: ${product.status}');

        expect(product.prices, isNotNull);
        expect(product.prices, isNotEmpty);

        // Print prices for the first product
        print('Prices for the first product:');
        for (final price in result.data.first.prices!) {
          print('  Price ID: ${price.id}');
          print('  Description: ${price.description}');
          print('  Type: ${price.type}');
          print('  Unit Price: ${price.unitPrice}');
        }
      },
    );

    test('getProduct returns a single product', () async {
      // First, list products to get a valid product ID
      final listResult = await client.products.listProducts();

      expect(listResult.data, isNotEmpty);

      // Get the ID of the first product
      final productId = listResult.data.first.id;

      // Call the API to get a specific product
      final result = await client.products.getProduct(
        productId,
        include: [ProductInclude.prices],
      );

      // Verify the result
      expect(result, isA<Resource<Product>>());
      expect(result.data.id, equals(productId));

      // Print some info about the returned product
      final product = result.data;
      print('Retrieved product:');
      print('  ID: ${product.id}');
      print('  Name: ${product.name}');
      print('  Status: ${product.status}');
      print('  Type: ${product.type}');
      print('  Tax Category: ${product.taxCategory}');

      expect(result.data.prices, isNotNull);

      // Print prices for the product
      print('Prices for the product:');
      for (final price in product.prices!) {
        print('  Price ID: ${price.id}');
        print('  Description: ${price.description}');
        print('  Type: ${price.type}');
        print('  Unit Price: ${price.unitPrice}');
      }
    });
  });
}
