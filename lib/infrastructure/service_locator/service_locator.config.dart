// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/authentication/data/datasource/local/authentication_local_dts.dart'
    as _i16;
import '../../modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart'
    as _i6;
import '../../modules/authentication/data/repositories/authentication_repo_impl.dart'
    as _i18;
import '../../modules/authentication/domain/repositories/authentication_repo.dart'
    as _i17;
import '../../modules/authentication/domain/usecases/get_current_session.dart'
    as _i21;
import '../../modules/authentication/domain/usecases/login.dart' as _i23;
import '../../modules/authentication/domain/usecases/logout.dart' as _i25;
import '../../modules/authentication/domain/usecases/register_user.dart'
    as _i27;
import '../../modules/authentication/presentation/screens/login/bloc/login_bloc.dart'
    as _i24;
import '../../modules/authentication/presentation/screens/register_user/bloc/register_user_bloc.dart'
    as _i28;
import '../../modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart'
    as _i30;
import '../../modules/quizz/data/datasource/local/quiz_local_dts.dart' as _i10;
import '../../modules/quizz/data/datasource/remote/quiz_remote_dts.dart'
    as _i11;
import '../../modules/quizz/data/repositories/quiz_repo_impl.dart' as _i13;
import '../../modules/quizz/domain/repositories/quiz_repo.dart' as _i12;
import '../../modules/quizz/domain/usecases/cached_quizzes.dart' as _i19;
import '../../modules/quizz/domain/usecases/get_cached_quizzes.dart' as _i20;
import '../../modules/quizz/domain/usecases/get_quiz_data.dart' as _i22;
import '../../modules/quizz/presentation/bloc/quiz_bloc.dart' as _i26;
import '../architecutre/blocs/messenger/messenger_cubit.dart' as _i9;
import '../architecutre/blocs/session/session_bloc.dart' as _i29;
import '../http_client/api_client.dart' as _i3;
import '../http_client/auth_client_impl.dart' as _i4;
import '../http_client/cb_client_impl.dart' as _i5;
import '../local_storage/hive/hive_local_storage.dart' as _i8;
import '../local_storage/secure_storage/secure_storage.dart' as _i14;
import '../supabase/supabase_config.dart' as _i15;
import 'modules/core_module.dart' as _i31;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModules = _$CoreModules();
    gh.lazySingleton<_i3.APIClient>(
      () => _i4.AuthClient(),
      instanceName: 'AuthClient',
    );
    gh.lazySingleton<_i3.APIClient>(
      () => _i5.MGClient(),
      instanceName: 'CBClient',
    );
    gh.factory<_i6.AuthenticationRemoteDTS>(
        () => _i6.AuthenticationRemoteDTSImpl());
    gh.factory<_i7.FlutterSecureStorage>(
        () => coreModules.getFlutterSecureStorage());
    gh.factory<_i8.HiveLocalStorage>(() => _i8.HiveLocalStorageImpl());
    gh.lazySingleton<_i9.MessengerCubit>(() => _i9.MessengerCubit());
    gh.factory<_i10.QuizLocalDts>(
        () => _i10.QuizLocalDtsImpl(gh<_i8.HiveLocalStorage>()));
    gh.factory<_i11.QuizRemoteDts>(() =>
        _i11.QuizRemoteDtsImpl(gh<_i3.APIClient>(instanceName: 'CBClient')));
    gh.factory<_i12.QuizRepo>(() => _i13.QuizRepoImpl(
          gh<_i11.QuizRemoteDts>(),
          gh<_i10.QuizLocalDts>(),
        ));
    gh.factory<_i14.SecureStorage>(
        () => _i14.SecureStorageImpl(gh<_i7.FlutterSecureStorage>()));
    gh.factory<_i15.SupabaseConfig>(() => _i15.SupabaseConfigImpl());
    gh.factory<_i16.AuthenticationLocalDTS>(
        () => _i16.AuthLocalDTSImpl(gh<_i14.SecureStorage>()));
    gh.factory<_i17.AuthenticationRepo>(() => _i18.AuthenticationRepoImpl(
          gh<_i6.AuthenticationRemoteDTS>(),
          gh<_i16.AuthenticationLocalDTS>(),
        ));
    gh.factory<_i19.CachedQuizzes>(
        () => _i19.CachedQuizzes(gh<_i12.QuizRepo>()));
    gh.factory<_i20.GetCachedQuizzes>(
        () => _i20.GetCachedQuizzes(gh<_i12.QuizRepo>()));
    gh.factory<_i21.GetCurrentSession>(
        () => _i21.GetCurrentSession(gh<_i17.AuthenticationRepo>()));
    gh.factory<_i22.GetQuizData>(() => _i22.GetQuizData(gh<_i12.QuizRepo>()));
    gh.factory<_i23.Login>(() => _i23.Login(gh<_i17.AuthenticationRepo>()));
    gh.factory<_i24.LoginBloc>(() => _i24.LoginBloc(gh<_i23.Login>()));
    gh.factory<_i25.Logout>(() => _i25.Logout(gh<_i17.AuthenticationRepo>()));
    gh.factory<_i26.QuizBloc>(() => _i26.QuizBloc(
          gh<_i22.GetQuizData>(),
          gh<_i20.GetCachedQuizzes>(),
          gh<_i19.CachedQuizzes>(),
        ));
    gh.factory<_i27.RegisterUser>(
        () => _i27.RegisterUser(gh<_i17.AuthenticationRepo>()));
    gh.factory<_i28.RegisterUserBloc>(
        () => _i28.RegisterUserBloc(gh<_i27.RegisterUser>()));
    gh.lazySingleton<_i29.SessionBloc>(
        () => _i29.SessionBloc(gh<_i25.Logout>()));
    gh.factory<_i30.SplashCubit>(
        () => _i30.SplashCubit(gh<_i21.GetCurrentSession>()));
    return this;
  }
}

class _$CoreModules extends _i31.CoreModules {}
