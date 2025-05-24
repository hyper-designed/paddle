import 'dart:async';

import 'package:chopper/chopper.dart';

class PaddleEssentialHeadersInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request.copyWith(
      headers: {'Paddle-Version': '1', 'Content-Type': 'application/json'},
    );
    return chain.proceed(request);
  }
}

class PaddleAuthHeadersInterceptor implements Interceptor {
  final String apiKey;

  PaddleAuthHeadersInterceptor({required this.apiKey});

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request.copyWith(
      headers: <String, String>{'Authorization': 'Bearer $apiKey'},
    );
    return chain.proceed(request);
  }
}
