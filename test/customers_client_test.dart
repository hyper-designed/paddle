import 'package:paddle/paddle.dart';
import 'package:test/test.dart';

import 'env.dart';

void main() {
  late PaddleClient client;

  setUpAll(() {
    if (apiKey == null) {
      fail(
        'PADDLE_API_KEY environment variable not set. Please set it to run this test.',
      );
    }

    client = PaddleClient(apiKey: apiKey!, sandbox: true, enableLogging: true);
  });

  group('CustomersClient', () {
    test('listCustomers returns a specific email', () async {
      final result = await client.customers.listCustomers(email: [testEmail]);

      expect(result, isA<CustomerList>());
      expect(result.data, isNotEmpty);
    });
  });
}
