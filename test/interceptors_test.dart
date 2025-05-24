import 'package:chopper/chopper.dart';
import 'package:paddle/src/api/interceptors.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  final baseUrl = Uri.parse('https://api.paddle.com');

  group('PaddleEssentialHeadersInterceptor', () {
    late PaddleEssentialHeadersInterceptor interceptor;

    setUp(() {
      interceptor = PaddleEssentialHeadersInterceptor();
    });

    test('adds Paddle-Version header to all requests', () async {
      final request = Request('GET', Uri.parse('/test'), baseUrl);
      final chain = _MockChain(request);

      await interceptor.intercept(chain);

      expect(chain.lastRequest?.headers['Paddle-Version'], equals('1'));
    });

    test('adds Content-Type header to POST requests', () async {
      final request = Request('POST', Uri.parse('/test'), baseUrl);
      final chain = _MockChain(request);

      await interceptor.intercept(chain);

      expect(chain.lastRequest?.headers['Content-Type'], equals('application/json'));
      expect(chain.lastRequest?.headers['Paddle-Version'], equals('1'));
    });

    test('adds Content-Type header to PUT requests', () async {
      final request = Request('PUT', Uri.parse('/test'), baseUrl);
      final chain = _MockChain(request);

      await interceptor.intercept(chain);

      expect(chain.lastRequest?.headers['Content-Type'], equals('application/json'));
      expect(chain.lastRequest?.headers['Paddle-Version'], equals('1'));
    });

    test('adds Content-Type header to PATCH requests', () async {
      final request = Request('PATCH', Uri.parse('/test'), baseUrl);
      final chain = _MockChain(request);

      await interceptor.intercept(chain);

      expect(chain.lastRequest?.headers['Content-Type'], equals('application/json'));
      expect(chain.lastRequest?.headers['Paddle-Version'], equals('1'));
    });

    test('does not add Content-Type header to GET requests', () async {
      final request = Request('GET', Uri.parse('/test'), baseUrl);
      final chain = _MockChain(request);

      await interceptor.intercept(chain);

      expect(chain.lastRequest?.headers['Content-Type'], isNull);
      expect(chain.lastRequest?.headers['Paddle-Version'], equals('1'));
    });

    test('preserves existing headers', () async {
      final request = Request(
        'POST',
        Uri.parse('/test'),
        baseUrl,
        headers: {'Custom-Header': 'custom-value'},
      );
      final chain = _MockChain(request);

      await interceptor.intercept(chain);

      expect(chain.lastRequest?.headers['Custom-Header'], equals('custom-value'));
      expect(chain.lastRequest?.headers['Content-Type'], equals('application/json'));
      expect(chain.lastRequest?.headers['Paddle-Version'], equals('1'));
    });
  });

  group('PaddleAuthHeadersInterceptor', () {
    late PaddleAuthHeadersInterceptor interceptor;
    const apiKey = 'test-api-key';

    setUp(() {
      interceptor = PaddleAuthHeadersInterceptor(apiKey: apiKey);
    });

    test('adds Authorization header with Bearer token', () async {
      final request = Request('GET', Uri.parse('/test'), baseUrl);
      final chain = _MockChain(request);

      await interceptor.intercept(chain);

      expect(chain.lastRequest?.headers['Authorization'], equals('Bearer $apiKey'));
    });

    test('preserves existing headers', () async {
      final request = Request(
        'GET',
        Uri.parse('/test'),
        baseUrl,
        headers: {'Custom-Header': 'custom-value'},
      );
      final chain = _MockChain(request);

      await interceptor.intercept(chain);

      expect(chain.lastRequest?.headers['Custom-Header'], equals('custom-value'));
      expect(chain.lastRequest?.headers['Authorization'], equals('Bearer $apiKey'));
    });
  });
}

class _MockChain implements Chain {
  _MockChain(this.request);

  @override
  final Request request;

  Request? lastRequest;

  @override
  Future<Response> proceed(Request request) async {
    lastRequest = request;
    final httpResponse = http.Response('{}', 200);
    return Response(httpResponse, null);
  }
}