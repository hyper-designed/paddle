import 'dart:async';

import 'package:chopper/chopper.dart';

class PaddleEssentialHeadersInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final headers = Map<String, String>.from(chain.request.headers);
    headers['Paddle-Version'] = '1';

    final method = chain.request.method.toUpperCase();
    if (method == 'POST' || method == 'PUT' || method == 'PATCH') {
      headers['Content-Type'] = 'application/json';
    }

    final request = chain.request.copyWith(headers: headers);
    return chain.proceed(request);
  }
}

class PaddleAuthHeadersInterceptor implements Interceptor {
  final String apiKey;

  PaddleAuthHeadersInterceptor({required this.apiKey});

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final headers = Map<String, String>.from(chain.request.headers);
    headers['Authorization'] = 'Bearer $apiKey';

    final request = chain.request.copyWith(headers: headers);
    return chain.proceed(request);
  }
}
