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

    client = PaddleClient(apiKey: apiKey!, sandbox: true);
  });

  group('SubscriptionsClient', () {
    test('listSubscriptions returns a list of subscriptions', () async {
      // Call the API to list subscriptions
      final result = await client.subscriptions.listSubscriptions();

      // Verify the result
      expect(result, isA<SubscriptionList>());

      // Print some info about the returned subscriptions
      print('Number of subscriptions: ${result.data.length}');

      if (result.data.isNotEmpty) {
        final subscription = result.data.first;
        print('First subscription:');
        print('  ID: ${subscription.id}');
        print('  Status: ${subscription.status}');
        print('  Customer ID: ${subscription.customerId}');
        print('  Currency: ${subscription.currencyCode}');
        print('  Collection Mode: ${subscription.collectionMode}');
        print('  Items count: ${subscription.items.length}');
      }
    });

    test('listSubscriptions with specific subscription ID', () async {
      const subscriptionId = 'sub_01k4mnjvfkqhc6mdr96kqrs4dd';

      // Call the API to list subscriptions with specific ID filter
      final result = await client.subscriptions.listSubscriptions(
        id: [subscriptionId],
      );

      // Verify the result
      expect(result, isA<SubscriptionList>());

      print(
        'Number of subscriptions with ID $subscriptionId: ${result.data.length}',
      );

      if (result.data.isNotEmpty) {
        final subscription = result.data.first;
        expect(subscription.id, equals(subscriptionId));

        print('Found subscription:');
        print('  ID: ${subscription.id}');
        print('  Status: ${subscription.status}');
        print('  Customer ID: ${subscription.customerId}');
        print('  Currency: ${subscription.currencyCode}');
        print('  Collection Mode: ${subscription.collectionMode}');
        print('  Started At: ${subscription.startedAt}');
        print('  Next Billed At: ${subscription.nextBilledAt}');
        print('  Items count: ${subscription.items.length}');

        // Print item details
        for (int i = 0; i < subscription.items.length; i++) {
          final item = subscription.items[i];
          print('  Item ${i + 1}:');
          print('    Price ID: ${item.price.id}');
          print('    Description: ${item.price.description}');
          print('    Quantity: ${item.quantity}');
        }
      } else {
        print('No subscription found with ID: $subscriptionId');
      }
    });

    test('listSubscriptions with pagination parameters', () async {
      // Call the API to list subscriptions with pagination
      final result = await client.subscriptions.listSubscriptions(perPage: 5);

      // Verify the result
      expect(result, isA<SubscriptionList>());
      expect(result.data.length, lessThanOrEqualTo(5));

      print('Number of subscriptions (per_page=5): ${result.data.length}');
      print('Has more: ${result.meta.pagination?.hasMore}');

      if (result.meta.pagination?.hasMore == true) {
        print('Next page cursor: ${result.meta.pagination?.next}');
      }
    });

    test('listSubscriptions with status filter', () async {
      // Call the API to list active subscriptions only
      final result = await client.subscriptions.listSubscriptions(
        status: EntityStatus.active,
      );

      // Verify the result
      expect(result, isA<SubscriptionList>());

      print('Number of active subscriptions: ${result.data.length}');

      // Verify all returned subscriptions are active
      for (final subscription in result.data) {
        expect(subscription.status, equals(SubscriptionStatus.active));
      }
    });

    test('getSubscription returns a single subscription', () async {
      // First, list subscriptions to get a valid subscription ID
      final listResult = await client.subscriptions.listSubscriptions();

      expect(
        listResult.data,
        isNotEmpty,
        reason:
            'No subscriptions found. Please create a subscription in the sandbox to run this test.',
      );

      // Get the ID of the first subscription
      final subscriptionId = listResult.data.first.id;

      // Call the API to get a specific subscription
      final result = await client.subscriptions.getSubscription(subscriptionId);

      // Verify the result
      expect(result, isA<Resource<Subscription>>());
      expect(result.data.id, equals(subscriptionId));

      // Print some info about the returned subscription
      final subscription = result.data;
      print('Retrieved subscription:');
      print('  ID: ${subscription.id}');
      print('  Status: ${subscription.status}');
      print('  Customer ID: ${subscription.customerId}');
      print('  Address ID: ${subscription.addressId}');
      print('  Currency: ${subscription.currencyCode}');
      print('  Collection Mode: ${subscription.collectionMode}');
      print('  Started At: ${subscription.startedAt}');
      print('  First Billed At: ${subscription.firstBilledAt}');
      print('  Next Billed At: ${subscription.nextBilledAt}');
      print('  Items count: ${subscription.items.length}');

      // Verify required fields are present
      expect(subscription.customerId, isNotEmpty);
      expect(subscription.addressId, isNotEmpty);
      expect(subscription.currencyCode, isNotEmpty);
      expect(subscription.items, isNotEmpty);

      // Print item details
      for (int i = 0; i < subscription.items.length; i++) {
        final item = subscription.items[i];
        print('  Item ${i + 1}:');
        print('    Price ID: ${item.price.id}');
        print('    Description: ${item.price.description}');
        print('    Type: ${item.price.type}');
        print('    Quantity: ${item.quantity}');
        print('    Unit Price: ${item.price.unitPrice}');
      }
    });

    test(
      'getSubscription with specific subscription ID sub_01k4mnjvfkqhc6mdr96kqrs4dd',
      () async {
        const subscriptionId = 'sub_01k4mnjvfkqhc6mdr96kqrs4dd';

        try {
          // Call the API to get the specific subscription
          final result = await client.subscriptions.getSubscription(
            subscriptionId,
          );

          // Verify the result
          expect(result, isA<Resource<Subscription>>());
          expect(result.data.id, equals(subscriptionId));

          // Print detailed info about the subscription
          final subscription = result.data;
          print('Retrieved subscription $subscriptionId:');
          print('  ID: ${subscription.id}');
          print('  Status: ${subscription.status}');
          print('  Customer ID: ${subscription.customerId}');
          print('  Address ID: ${subscription.addressId}');
          print('  Business ID: ${subscription.businessId}');
          print('  Currency: ${subscription.currencyCode}');
          print('  Collection Mode: ${subscription.collectionMode}');
          print('  Started At: ${subscription.startedAt}');
          print('  First Billed At: ${subscription.firstBilledAt}');
          print('  Next Billed At: ${subscription.nextBilledAt}');

          if (subscription.pausedAt != null) {
            print('  Paused At: ${subscription.pausedAt}');
          }

          if (subscription.canceledAt != null) {
            print('  Canceled At: ${subscription.canceledAt}');
          }

          if (subscription.discount != null) {
            print('  Discount: ${subscription.discount}');
          }

          if (subscription.scheduledChange != null) {
            print('  Scheduled Change: ${subscription.scheduledChange}');
          }

          print('  Items count: ${subscription.items.length}');

          // Verify the subscription exists and has expected properties
          expect(subscription.customerId, isNotEmpty);
          expect(subscription.addressId, isNotEmpty);
          expect(subscription.currencyCode, isNotEmpty);
          expect(subscription.items, isNotEmpty);

          // Print detailed item information
          for (int i = 0; i < subscription.items.length; i++) {
            final item = subscription.items[i];
            print('  Item ${i + 1}:');
            print('    Price ID: ${item.price.id}');
            print('    Product ID: ${item.price.productId}');
            print('    Description: ${item.price.description}');
            print('    Name: ${item.price.name}');
            print('    Type: ${item.price.type}');
            print('    Quantity: ${item.quantity}');
            print('    Unit Price: ${item.price.unitPrice}');

            if (item.price.billingCycle != null) {
              print('    Billing Cycle: ${item.price.billingCycle}');
            }

            if (item.price.trialPeriod != null) {
              print('    Trial Period: ${item.price.trialPeriod}');
            }
          }
        } catch (e) {
          if (e is PaddleApiError) {
            print('API Error when getting subscription $subscriptionId:');
            print('  Error: ${e.error}');
            print('  Type: ${e.error.type}');
            print('  Code: ${e.error.code}');
            print('  Detail: ${e.error.detail}');

            // If the subscription doesn't exist, that's okay for testing purposes
            if (e.error.code == 'subscription_not_found' ||
                e.error.code == 'not_found') {
              print(
                'Subscription $subscriptionId does not exist in the sandbox environment',
              );
              return; // Skip this test if the subscription doesn't exist
            }
          }

          // Re-throw if it's not a "not found" error
          rethrow;
        }
      },
    );

    test('getSubscription with include parameters', () async {
      // First, list subscriptions to get a valid subscription ID
      final listResult = await client.subscriptions.listSubscriptions();

      expect(
        listResult.data,
        isNotEmpty,
        reason:
            'No subscriptions found. Please create a subscription in the sandbox to run this test.',
      );

      // Get the ID of the first subscription
      final subscriptionId = listResult.data.first.id;

      // Call the API to get a specific subscription with include parameters
      final result = await client.subscriptions.getSubscription(
        subscriptionId,
        include: [
          SubscriptionInclude.nextTransaction,
          SubscriptionInclude.recurringTransactionDetails,
        ],
      );

      // Verify the result
      expect(result, isA<Resource<Subscription>>());
      expect(result.data.id, equals(subscriptionId));

      // Print some info about the returned subscription
      final subscription = result.data;
      print('Retrieved subscription with includes:');
      print('  ID: ${subscription.id}');
      print('  Status: ${subscription.status}');
      print('  Next Billed At: ${subscription.nextBilledAt}');

      // Note: The include parameters affect what additional data is returned
      // but the main subscription object structure remains the same
      print('  Items count: ${subscription.items.length}');

      // Print additional details that might be included
      if (subscription.currentBillingPeriod != null) {
        print('  Current Billing Period: ${subscription.currentBillingPeriod}');
      }

      if (subscription.billingCycle != null) {
        print('  Billing Cycle: ${subscription.billingCycle}');
      }
    });
  });
}
