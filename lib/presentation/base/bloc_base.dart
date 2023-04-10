part of 'base.dart';

abstract class AppBlocBase<E, S> extends Bloc<E, S> {
  Function(ErrorData)? errorHandler;

  LocalDataManager get localDataManager => injector.get();

  AppBlocBase(S s) : super(s);

  bool get isLoggedIn => injector.get<AuthService>().isSignedIn;

  EventTransformer<T> debounceSequential<T>(Duration duration) {
    return (events, mapper) =>
        events.debounceTime(duration).asyncExpand(mapper);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {

    // TODO(nuno314): rest apis 
    super.onError(error, stackTrace);
  }
}
