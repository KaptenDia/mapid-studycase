// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:baseproject_flutter/config/di/register_module.dart' as _i77;
import 'package:baseproject_flutter/const/code.dart' as _i265;
import 'package:baseproject_flutter/helper/api/api_client.dart' as _i569;
import 'package:baseproject_flutter/helper/navigator.dart' as _i787;
import 'package:baseproject_flutter/module/auth/data/auth_repository.dart'
    as _i952;
import 'package:baseproject_flutter/module/login/data/login_local_data.dart'
    as _i828;
import 'package:baseproject_flutter/module/login/data/login_remote_data.dart'
    as _i754;
import 'package:baseproject_flutter/module/login/data/login_repository.dart'
    as _i508;
import 'package:baseproject_flutter/module/login/domain/login_use_case.dart'
    as _i615;
import 'package:baseproject_flutter/module/register/data/register_local_data.dart'
    as _i528;
import 'package:baseproject_flutter/module/register/data/register_remote_data.dart'
    as _i948;
import 'package:baseproject_flutter/module/register/data/register_repository.dart'
    as _i408;
import 'package:baseproject_flutter/module/register/domain/register_use_case.dart'
    as _i784;
import 'package:baseproject_flutter/shared/translation/translation_service.dart'
    as _i511;
import 'package:dio/dio.dart' as _i361;
import 'package:encrypt_shared_preferences/provider.dart' as _i930;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
    gh.lazySingleton<_i265.RespBodyCode>(() => _i265.RespBodyCode());
    gh.lazySingleton<_i265.HttpStatusCode>(() => _i265.HttpStatusCode());
    gh.lazySingleton<_i787.AppNavigator>(() => _i787.AppNavigator());
    gh.lazySingleton<_i511.TranslationService>(
      () => _i511.TranslationService(gh<_i930.EncryptedSharedPreferences>()),
    );
    gh.lazySingleton<_i828.ILoginLocalData>(
      () => _i828.LoginLocalData(gh<_i930.EncryptedSharedPreferences>()),
    );
    gh.lazySingleton<_i569.ApiClient>(() => _i569.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i528.IRegisterLocalData>(
      () => _i528.RegisterLocalData(gh<_i930.EncryptedSharedPreferences>()),
    );
    gh.lazySingleton<_i952.IAuthRepository>(
      () => _i952.AuthRepository(gh<_i828.ILoginLocalData>()),
    );
    gh.lazySingleton<_i754.ILoginRemoteData>(
      () => _i754.LoginRemoteData(gh<_i569.ApiClient>()),
    );
    gh.lazySingleton<_i948.IRegisterRemoteData>(
      () => _i948.RegisterRemoteData(gh<_i569.ApiClient>()),
    );
    gh.lazySingleton<_i408.IRegisterRepository>(
      () => _i408.RegisterRepository(
        gh<_i948.IRegisterRemoteData>(),
        gh<_i528.IRegisterLocalData>(),
      ),
    );
    gh.lazySingleton<_i508.ILoginRepository>(
      () => _i508.LoginRepository(
        gh<_i754.ILoginRemoteData>(),
        gh<_i828.ILoginLocalData>(),
      ),
    );
    gh.lazySingleton<_i615.ILoginUseCase>(
      () => _i615.LoginUseCase(gh<_i508.ILoginRepository>()),
    );
    gh.lazySingleton<_i784.IRegisterUseCase>(
      () => _i784.RegisterUseCase(gh<_i408.IRegisterRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i77.RegisterModule {}
