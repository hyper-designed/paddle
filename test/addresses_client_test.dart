import 'package:paddle/paddle.dart';
import 'package:test/test.dart';

import 'env.dart';

void main() {
  late PaddleClient client;

  late final String customerId;

  setUpAll(() async {
    if (apiKey == null) {
      fail(
        'PADDLE_API_KEY environment variable not set. Please set it to run this test.',
      );
    }

    client = PaddleClient(apiKey: apiKey!, sandbox: true, enableLogging: true);

    final customer = await client.customers.listCustomers(email: [testEmail]);
    customerId = customer.data.first.id;
  });

  group('AddressesClient', () {
    test('listAddresses returns a list of addresses', () async {
      final result = await client.addresses.listAddresses(
        customerId: customerId,
      );

      expect(result.data, isA<List<Address>>());
      expect(result.meta, isA<ResourceMeta>());
    });

    test('getAddress returns a specific address', () async {
      final result = await client.addresses.listAddresses(
        customerId: customerId,
      );

      final addressId = result.data.first.id;

      final addressObj = await client.addresses.getAddress(
        customerId: customerId,
        addressId: addressId,
      );
      final address = addressObj.data;

      expect(address, isA<Address>());
      expect(address.id, equals(addressId));
      expect(address.countryCode, equals('LB'));
    });

    test('listAddresses with filters', () async {
      final result = await client.addresses.listAddresses(
        customerId: customerId,
        perPage: 10,
        orderBy: const AddressOrderBy(
          direction: SortDirection.ascending,
          field: AddressOrderField.id,
        ),
      );

      expect(result.data, isA<List<Address>>());
      expect(result.meta, isA<ResourceMeta>());
    });
  });
}
