// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/authentication/data/datasource/local/authentication_local_dts.dart'
    as _i21;
import '../../modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart'
    as _i6;
import '../../modules/authentication/data/repositories/authentication_repo_impl.dart'
    as _i23;
import '../../modules/authentication/domain/repositories/authentication_repo.dart'
    as _i22;
import '../../modules/authentication/domain/usecases/get_current_session.dart'
    as _i26;
import '../../modules/authentication/domain/usecases/login.dart' as _i28;
import '../../modules/authentication/domain/usecases/logout.dart' as _i30;
import '../../modules/authentication/domain/usecases/register_user.dart'
    as _i32;
import '../../modules/authentication/presentation/screens/login/bloc/login_bloc.dart'
    as _i29;
import '../../modules/authentication/presentation/screens/register_user/bloc/register_user_bloc.dart'
    as _i33;
import '../../modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart'
    as _i35;
import '../../modules/quizz/data/datasource/local/quiz_local_dts.dart' as _i15;
import '../../modules/quizz/data/datasource/remote/quiz_remote_dts.dart'
    as _i16;
import '../../modules/quizz/data/repositories/quiz_repo_impl.dart' as _i18;
import '../../modules/quizz/domain/repositories/quiz_repo.dart' as _i17;
import '../../modules/quizz/domain/usecases/cached_quizzes.dart' as _i24;
import '../../modules/quizz/domain/usecases/get_cached_quizzes.dart' as _i25;
import '../../modules/quizz/domain/usecases/get_quiz_data.dart' as _i27;
import '../../modules/quizz/presentation/bloc/quiz_bloc.dart' as _i31;
import '../../modules/transaction/data/datasource/remote/category_remote_dts.dart'
    as _i7;
import '../../modules/transaction/data/repository_impls/category_repositories_impl.dart'
    as _i9;
import '../../modules/transaction/domain/repositories/category_repositories.dart'
    as _i8;
import '../../modules/transaction/domain/usecases/get_categories.dart' as _i11;
import '../../modules/transaction/presentation/screens/income/bloc/income_transaction_bloc.dart'
    as _i13;
import '../architecutre/blocs/messenger/messenger_cubit.dart' as _i14;
import '../architecutre/blocs/session/session_bloc.dart' as _i34;
import '../http_client/api_client.dart' as _i3;
import '../http_client/auth_client_impl.dart' as _i4;
import '../http_client/cb_client_impl.dart' as _i5;
import '../local_storage/hive/hive_local_storage.dart' as _i12;
import '../local_storage/secure_storage/secure_storage.dart' as _i19;
import '../supabase/supabase_config.dart' as _i20;
import 'modules/core_module.dart' as _i36;

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
    gh.factory<_i7.CategoryRemoteDts>(() => _i7.CategoryRemoteDtsImpl());
    gh.factory<_i8.CategoryRepo>(
        () => _i9.CategoryRepoImpl(gh<_i7.CategoryRemoteDts>()));
    gh.factory<_i10.FlutterSecureStorage>(
        () => coreModules.getFlutterSecureStorage());
    gh.factory<_i11.GetCategories>(
        () => _i11.GetCategories(gh<_i8.CategoryRepo>()));
    gh.factory<_i12.HiveLocalStorage>(() => _i12.HiveLocalStorageImpl());
    gh.factory<_i13.IncomeTransactionBloc>(
        () => _i13.IncomeTransactionBloc(gh<_i11.GetCategories>()));
    gh.lazySingleton<_i14.MessengerCubit>(() => _i14.MessengerCubit());
    gh.factory<_i15.QuizLocalDts>(
        () => _i15.QuizLocalDtsImpl(gh<_i12.HiveLocalStorage>()));
    gh.factory<_i16.QuizRemoteDts>(() =>
        _i16.QuizRemoteDtsImpl(gh<_i3.APIClient>(instanceName: 'CBClient')));
    gh.factory<_i17.QuizRepo>(() => _i18.QuizRepoImpl(
          gh<_i16.QuizRemoteDts>(),
          gh<_i15.QuizLocalDts>(),
        ));
    gh.factory<_i19.SecureStorage>(
        () => _i19.SecureStorageImpl(gh<_i10.FlutterSecureStorage>()));
    gh.factory<_i20.SupabaseConfig>(() => _i20.SupabaseConfigImpl());
    gh.factory<_i21.AuthenticationLocalDTS>(
        () => _i21.AuthLocalDTSImpl(gh<_i19.SecureStorage>()));
    gh.factory<_i22.AuthenticationRepo>(() => _i23.AuthenticationRepoImpl(
          gh<_i6.AuthenticationRemoteDTS>(),
          gh<_i21.AuthenticationLocalDTS>(),
        ));
    gh.factory<_i24.CachedQuizzes>(
        () => _i24.CachedQuizzes(gh<_i17.QuizRepo>()));
    gh.factory<_i25.GetCachedQuizzes>(
        () => _i25.GetCachedQuizzes(gh<_i17.QuizRepo>()));
    gh.factory<_i26.GetCurrentSession>(
        () => _i26.GetCurrentSession(gh<_i22.AuthenticationRepo>()));
    gh.factory<_i27.GetQuizData>(() => _i27.GetQuizData(gh<_i17.QuizRepo>()));
    gh.factory<_i28.Login>(() => _i28.Login(gh<_i22.AuthenticationRepo>()));
    gh.factory<_i29.LoginBloc>(() => _i29.LoginBloc(gh<_i28.Login>()));
    gh.factory<_i30.Logout>(() => _i30.Logout(gh<_i22.AuthenticationRepo>()));
    gh.factory<_i31.QuizBloc>(() => _i31.QuizBloc(
          gh<_i27.GetQuizData>(),
          gh<_i25.GetCachedQuizzes>(),
          gh<_i24.CachedQuizzes>(),
        ));
    gh.factory<_i32.RegisterUser>(
        () => _i32.RegisterUser(gh<_i22.AuthenticationRepo>()));
    gh.factory<_i33.RegisterUserBloc>(
        () => _i33.RegisterUserBloc(gh<_i32.RegisterUser>()));
    gh.lazySingleton<_i34.SessionBloc>(
        () => _i34.SessionBloc(gh<_i30.Logout>()));
    gh.factory<_i35.SplashCubit>(
        () => _i35.SplashCubit(gh<_i26.GetCurrentSession>()));
    return this;
  }
}

class _$CoreModules extends _i36.CoreModules {}
