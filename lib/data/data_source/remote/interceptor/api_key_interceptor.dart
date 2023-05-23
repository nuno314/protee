import 'package:dio/dio.dart';

class ApiKeyInterceptor extends Interceptor {
  final String apiKey;

  ApiKeyInterceptor(this.apiKey);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['key'] = apiKey;
    options.queryParameters['rankby'] = 'distance';
    super.onRequest(options, handler);
  }
}
