// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:encrypt_shared_preferences/provider.dart' as _i930;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mapid/config/di/register_module.dart' as _i109;
import 'package:mapid/const/code.dart' as _i24;
import 'package:mapid/helper/api/api_client.dart' as _i434;
import 'package:mapid/helper/navigator.dart' as _i251;
import 'package:mapid/module/auth/data/auth_repository.dart' as _i504;
import 'package:mapid/module/login/data/login_local_data.dart' as _i120;
import 'package:mapid/module/login/data/login_remote_data.dart' as _i557;
import 'package:mapid/module/login/data/login_repository.dart' as _i702;
import 'package:mapid/module/login/domain/login_use_case.dart' as _i717;
import 'package:mapid/module/map/data/map_remote_data.dart' as _i852;
import 'package:mapid/module/map/data/map_repository.dart' as _i483;
import 'package:mapid/module/map/domain/map_use_case.dart' as _i118;
import 'package:mapid/module/register/data/register_local_data.dart' as _i201;
import 'package:mapid/module/register/data/register_remote_data.dart' as _i595;
import 'package:mapid/module/register/data/register_repository.dart' as _i883;
import 'package:mapid/module/register/domain/register_use_case.dart' as _i632;
import 'package:mapid/shared/translation/translation_service.dart' as _i628;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i930.EncryptedSharedPreferences>(() => registerModule.prefs);
    gh.factory<_i361.Dio>(() => registerModule.httpClient);
    gh.lazySingleton<_i24.RespBodyCode>(() => _i24.RespBodyCode());
    gh.lazySingleton<_i24.HttpStatusCode>(() => _i24.HttpStatusCode());
    gh.lazySingleton<_i251.AppNavigator>(() => _i251.AppNavigator());
    gh.lazySingleton<_i120.ILoginLocalData>(
      () => _i120.LoginLocalData(gh<_i930.EncryptedSharedPreferences>()),
    );
    gh.lazySingleton<_i628.TranslationService>(
      () => _i628.TranslationService(gh<_i930.EncryptedSharedPreferences>()),
    );
    gh.lazySingleton<_i201.IRegisterLocalData>(
      () => _i201.RegisterLocalData(gh<_i930.EncryptedSharedPreferences>()),
    );
    gh.lazySingleton<_i434.ApiClient>(() => _i434.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i504.IAuthRepository>(
      () => _i504.AuthRepository(gh<_i120.ILoginLocalData>()),
    );
    gh.lazySingleton<_i852.IMapRemoteData>(
      () => _i852.MapRemoteData(gh<_i434.ApiClient>()),
    );
    gh.lazySingleton<_i557.ILoginRemoteData>(
      () => _i557.LoginRemoteData(gh<_i434.ApiClient>()),
    );
    gh.lazySingleton<_i595.IRegisterRemoteData>(
      () => _i595.RegisterRemoteData(gh<_i434.ApiClient>()),
    );
    gh.lazySingleton<_i483.IMapRepository>(
      () => _i483.MapRepository(gh<_i852.IMapRemoteData>()),
    );
    gh.lazySingleton<_i883.IRegisterRepository>(
      () => _i883.RegisterRepository(
        gh<_i595.IRegisterRemoteData>(),
        gh<_i201.IRegisterLocalData>(),
      ),
    );
    gh.lazySingleton<_i632.IRegisterUseCase>(
      () => _i632.RegisterUseCase(gh<_i883.IRegisterRepository>()),
    );
    gh.lazySingleton<_i702.ILoginRepository>(
      () => _i702.LoginRepository(
        gh<_i557.ILoginRemoteData>(),
        gh<_i120.ILoginLocalData>(),
      ),
    );
    gh.lazySingleton<_i118.IMapUseCase>(
      () => _i118.MapUseCase(gh<_i483.IMapRepository>()),
    );
    gh.lazySingleton<_i717.ILoginUseCase>(
      () => _i717.LoginUseCase(gh<_i702.ILoginRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i109.RegisterModule {}
