import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as dio_p;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pedantic/pedantic.dart';

import '../../../common/client_info.dart';
import '../../../common/config.dart';
import '../../../common/constants.dart';
import '../../../common/services/auth_service.dart';
import '../../../common/utils.dart';
import '../../../di/di.dart';
import '../local/local_data_manager.dart';
import 'interceptor/api_key_interceptor.dart';
import 'interceptor/auth_interceptor.dart';
import 'interceptor/header_interceptor.dart';
import 'interceptor/logger_interceptor.dart';
import 'location/location_repository.dart';
import 'rest_api_repository/rest_api_repository.dart';

part 'api_service_error.dart';

@Injectable()
class AppApiService {
  late dio_p.Dio dio;
  late dio_p.Dio locationRepositoryDio;
  late RestApiRepository client;
  late LocationRepository locationRepository;

  ApiServiceDelegate? apiServiceDelegate;

  final baseGoogleMapUrl = 'https://maps.googleapis.com/maps/api/';

  AppApiService() {
    _config();
  }

  LocalDataManager get localDataManager => injector.get();

  void _config() {
    _setupDioClient();

    _createRestClient();

    _setupDioLocationRepository();

    _createLocationRepository();
  }

  Map<String, String> _getDefaultHeader() {
    final defaultHeader = <String, String>{
      HttpConstants.contentType: 'application/json',
      HttpConstants.device: 'mobile',
      HttpConstants.model: ClientInfo.model,
      HttpConstants.osversion: ClientInfo.osversion,
      HttpConstants.appVersion: ClientInfo.appVersionName,
      HttpConstants.appVersionFull: ClientInfo.appVersion,
      HttpConstants.language: ClientInfo.languageCode,
    };

    if (!kIsWeb) {
      defaultHeader[HttpConstants.osplatform] = Platform.operatingSystem;
    }
    return defaultHeader;
  }

  void _setupDioClient() {
    dio = dio_p.Dio(
      dio_p.BaseOptions(
        followRedirects: false,
        receiveTimeout: 30000, // 30s
        sendTimeout: 30000, // 30s
      ),
    );

    dio.options.headers.clear();

    dio.options.headers = _getDefaultHeader();

    /// CERTIFICATE_VERIFY_FAILED
    final clientAdapter = dio.httpClientAdapter;
    if (clientAdapter is DefaultHttpClientAdapter) {
      clientAdapter.onHttpClientCreate = (client) {
        client.badCertificateCallback = (cert, host, port) {
          LogUtils.d({
            'From': 'AppApiService -> badCertificateCallback',
            'Time': DateTime.now().toString(),
            'host': host,
            'port': port,
            'cert': cert,
          });
          return true;
        };
        return client;
      };
    }

    /// Dio InterceptorsWrapper
    dio.interceptors.add(
      HeaderInterceptor(
        getHeader: _getDefaultHeader,
      ),
    );
    dio.interceptors.add(
      AuthInterceptor(
        getToken: () {
          final token = injector.get<AuthService>().token;
          return token.isNotNullOrEmpty ? '$token' : null;
        },
        refreshToken: (token, options) async {
          return refreshToken(token);
        },
        onLogoutRequest: () {
          unawaited(localDataManager.clearData());
        },
      ),
    );
    dio.interceptors.add(
      LoggerInterceptor(
        ignoreReponseDataLog: (response) {
          return false;
        },
      ),
    );
  }

  void _setupDioLocationRepository() {
    locationRepositoryDio = dio_p.Dio(
      dio_p.BaseOptions(
        followRedirects: false,
        receiveTimeout: 30000, // 30s
        sendTimeout: 30000, // 30s
      ),
    );

    locationRepositoryDio.interceptors.add(
      ApiKeyInterceptor('AIzaSyBJYFtYFzYcONJyHknTCoZQPp9ts7VgEns'),
    );

    locationRepositoryDio.interceptors.add(
      LoggerInterceptor(
        // implement ignore large logs if needed
        ignoreReponseDataLog: (response) {
          // return response.requestOptions.path == ApiContract.administrative;
          return false;
        },
      ),
    );
  }

  void _createRestClient() {
    client = RestApiRepository(
      dio,
      baseUrl: Config.instance.appConfig.baseApiLayer,
    );
  }

  void _createLocationRepository() {
    locationRepository = LocationRepository(
      locationRepositoryDio,
      baseUrl: baseGoogleMapUrl,
    );
  }

  Future<String?> refreshToken(String token, {bool saveToken = true}) async {
    final token = await injector.get<AuthService>().refreshToken();
    return token.isNotNullOrEmpty ? '$token' : null;
  }
}

mixin ApiServiceDelegate {
  void onError(ErrorData onError);
}
