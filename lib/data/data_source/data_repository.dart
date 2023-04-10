import '../../../di/di.dart';
import 'remote/app_api_service.dart';
import 'remote/rest_api_repository/rest_api_repository.dart';

mixin DataRepository {
  AppApiService appApiService = injector.get<AppApiService>();
  RestApiRepository get restApi => appApiService.client;

  void resetClient() {
    appApiService = injector.get<AppApiService>();
  }
}
