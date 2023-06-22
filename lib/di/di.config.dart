// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:protee/common/services/auth_service.dart' as _i5;
import 'package:protee/common/services/implementation/app_auth_service.dart'
    as _i6;
import 'package:protee/common/services/implementation/app_location_service.dart'
    as _i10;
import 'package:protee/common/services/implementation/firebase_upload_service.dart'
    as _i15;
import 'package:protee/common/services/implementation/location_plugin_service.dart'
    as _i8;
import 'package:protee/common/services/location_plugin_service.dart' as _i7;
import 'package:protee/common/services/location_service.dart' as _i9;
import 'package:protee/common/services/upload_service.dart' as _i14;
import 'package:protee/data/data_source/local/preferences_helper/preferences_helper.dart'
    as _i11;
import 'package:protee/data/data_source/remote/app_api_service.dart' as _i3;
import 'package:protee/presentation/common_bloc/app_data_bloc.dart' as _i4;
import 'package:protee/presentation/theme/theme_color.dart' as _i12;
import 'package:protee/presentation/theme/theme_dialog.dart' as _i13;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AppApiService>(() => _i3.AppApiService());
  gh.singletonAsync<_i4.AppDataBloc>(() => _i4.AppDataBloc.create());
  gh.singleton<_i5.AuthService>(_i6.AppAuthService());
  gh.singleton<_i7.LocationPluginService>(_i8.LocationPluginServiceImpl());
  gh.singleton<_i9.LocationService>(_i10.LocationServiceImpl());
  gh.factory<_i11.PreferencesHelper>(() => _i11.PreferencesHelperImpl());
  gh.singleton<_i12.ThemeColor>(_i12.ThemeColor());
  gh.factory<_i13.ThemeDialog>(() => _i13.ThemeDialog());
  gh.factory<_i14.UploadService>(() => _i15.FirebaseUploadService());
  return getIt;
}
