import 'package:chopper/chopper.dart' hide Level;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'clients/clients.dart';
import 'endpoints/endpoints.dart';
import 'interceptors.dart';

final class PaddleClient {
  static const String liveUrl = 'https://api.paddle.com/';
  static const String sandboxUrl = 'https://sandbox-api.paddle.com/';

  PaddleClient({
    required this.apiKey,
    bool enableLogging = false,
    this.httpClient,
    this.sandbox = false,
  }) : _loggingEnabled = enableLogging {
    _createClients(enableLogging: enableLogging, sandbox: sandbox);
  }

  final http.Client? httpClient;
  final String apiKey;
  final bool sandbox;
  late ChopperClient _chopperClient;

  bool _loggingEnabled = false;

  bool get loggingEnabled => _loggingEnabled;

  ProductsClient? _products;

  ProductsClient get products => _products!;

  SubscriptionsClient? _subscriptions;

  SubscriptionsClient get subscriptions => _subscriptions!;

  PricesClient? _prices;

  PricesClient get prices => _prices!;

  CustomersClient? _customers;

  CustomersClient get customers => _customers!;

  void _createClients({required bool enableLogging, required bool sandbox}) {
    final List<ChopperService> services = [
      SubscriptionsApi.create(),
      ProductsApi.create(),
      PricesApi.create(),
      CustomersApi.create(),
    ];
    _chopperClient = ChopperClient(
      baseUrl: Uri.parse(sandbox ? sandboxUrl : liveUrl),
      client: httpClient,
      interceptors: [
        PaddleEssentialHeadersInterceptor(),
        PaddleAuthHeadersInterceptor(apiKey: apiKey),
        if (enableLogging) HttpLoggingInterceptor(),
      ],
      services: services,
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
    );

    _subscriptions = SubscriptionsClient(_chopperClient.getService());
    _products = ProductsClient(_chopperClient.getService());
    _prices = PricesClient(_chopperClient.getService());
    _customers = CustomersClient(_chopperClient.getService());

    if (enableLogging) {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((record) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      });
    }
  }

  /// Enable/disable logging for all requests.
  void setLogging(bool value) {
    _loggingEnabled = value;
    _createClients(enableLogging: value, sandbox: sandbox);
  }
}
