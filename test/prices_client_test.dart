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

  group('PricesClient', () {
    test('listPrices returns a list of prices', () async {
      // Call the API to list prices
      final result = await client.prices.listPrices();

      // Verify the result
      expect(result, isA<PriceList>());

      // Print some info about the returned prices
      print('Number of prices: ${result.data.length}');

      if (result.data.isNotEmpty) {
        final price = result.data.first;
        print('First price:');
        print('  ID: ${price.id}');
        print('  Description: ${price.description}');
        print('  Type: ${price.type}');
        print('  Unit Price: ${price.unitPrice}');
        print('  Status: ${price.status}');
      }
    });

    test(
      'listPrices with include parameter returns prices with products',
      () async {
        // Call the API to list prices with product included
        final result = await client.prices.listPrices(
          include: [PriceInclude.product],
        );

        // Verify the result
        expect(result, isA<PriceList>());

        // Print some info about the returned prices
        print('Number of prices: ${result.data.length}');

        expect(result.data, isNotEmpty);

        final price = result.data.first;
        print('First price:');
        print('  ID: ${price.id}');
        print('  Description: ${price.description}');
        print('  Type: ${price.type}');

        expect(price.product, isNotNull);

        // Print product for the first price
        print('Product for the first price:');
        print('  Product ID: ${price.product!.id}');
        print('  Name: ${price.product!.name}');
        print('  Status: ${price.product!.status}');
      },
    );

    test('getPrice returns a single price', () async {
      // First, list prices to get a valid price ID
      final listResult = await client.prices.listPrices();

      expect(listResult.data, isNotEmpty);

      // Get the ID of the first price
      final priceId = listResult.data.first.id;

      // Call the API to get a specific price
      final result = await client.prices.getPrice(
        priceId,
        include: [PriceInclude.product],
      );

      // Verify the result
      expect(result, isA<Resource<Price>>());
      expect(result.data.id, equals(priceId));

      // Print some info about the returned price
      final price = result.data;
      print('Retrieved price:');
      print('  ID: ${price.id}');
      print('  Description: ${price.description}');
      print('  Type: ${price.type}');
      print('  Unit Price: ${price.unitPrice}');
      print('  Status: ${price.status}');

      expect(result.data.product, isNotNull);

      // Print product for the price
      print('Product for the price:');
      print('  Product ID: ${price.product!.id}');
      print('  Name: ${price.product!.name}');
      print('  Status: ${price.product!.status}');
    });
  });
}
