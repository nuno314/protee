import 'package:dio/dio.dart';

import '../location/api_contract.dart';

class ApiKeyInterceptor extends Interceptor {
  final String apiKey;

  ApiKeyInterceptor(this.apiKey);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['key'] = apiKey;
    if (options.path != GoogleMapApiContract.placeNearBySearch) {
      options.queryParameters['rankby'] = 'distance';
    }
    super.onRequest(options, handler);
  }
}
