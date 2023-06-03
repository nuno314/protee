part of 'account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final _restApi = injector.get<AppApiService>().client;
}
