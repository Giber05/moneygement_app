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
    as _i23;
import '../../modules/authentication/data/datasource/remote/authenticatation_remote_dts.dart'
    as _i6;
import '../../modules/authentication/data/repositories/authentication_repo_impl.dart'
    as _i25;
import '../../modules/authentication/domain/repositories/authentication_repo.dart'
    as _i24;
import '../../modules/authentication/domain/usecases/get_current_session.dart'
    as _i29;
import '../../modules/authentication/domain/usecases/login.dart' as _i32;
import '../../modules/authentication/domain/usecases/logout.dart' as _i34;
import '../../modules/authentication/domain/usecases/register_user.dart'
    as _i36;
import '../../modules/authentication/presentation/screens/login/bloc/login_bloc.dart'
    as _i33;
import '../../modules/authentication/presentation/screens/register_user/bloc/register_user_bloc.dart'
    as _i37;
import '../../modules/authentication/presentation/screens/splash/cubit/splash_cubit.dart'
    as _i39;
import '../../modules/quizz/data/datasource/local/quiz_local_dts.dart' as _i14;
import '../../modules/quizz/data/datasource/remote/quiz_remote_dts.dart'
    as _i15;
import '../../modules/quizz/data/repositories/quiz_repo_impl.dart' as _i17;
import '../../modules/quizz/domain/repositories/quiz_repo.dart' as _i16;
import '../../modules/quizz/domain/usecases/cached_quizzes.dart' as _i26;
import '../../modules/quizz/domain/usecases/get_cached_quizzes.dart' as _i28;
import '../../modules/quizz/domain/usecases/get_quiz_data.dart' as _i30;
import '../../modules/quizz/presentation/bloc/quiz_bloc.dart' as _i35;
import '../../modules/transaction/data/datasource/remote/category_remote_dts.dart'
    as _i7;
import '../../modules/transaction/data/datasource/remote/transaction_remote_dts.dart'
    as _i20;
import '../../modules/transaction/data/repository_impls/category_repositories_impl.dart'
    as _i9;
import '../../modules/transaction/data/repository_impls/transaction_repositories_impl.dart'
    as _i22;
import '../../modules/transaction/domain/repositories/category_repositories.dart'
    as _i8;
import '../../modules/transaction/domain/repositories/transaction_repositories.dart'
    as _i21;
import '../../modules/transaction/domain/usecases/create_transaction.dart'
    as _i27;
import '../../modules/transaction/domain/usecases/get_categories.dart' as _i11;
import '../../modules/transaction/presentation/screens/income/bloc/income_transaction_bloc.dart'
    as _i31;
import '../architecutre/blocs/messenger/messenger_cubit.dart' as _i13;
import '../architecutre/blocs/session/session_bloc.dart' as _i38;
import '../http_client/api_client.dart' as _i3;
import '../http_client/auth_client_impl.dart' as _i5;
import '../http_client/cb_client_impl.dart' as _i4;
import '../local_storage/hive/hive_local_storage.dart' as _i12;
import '../local_storage/secure_storage/secure_storage.dart' as _i18;
import '../supabase/supabase_config.dart' as _i19;
import 'modules/core_module.dart' as _i40;

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
      () => _i4.MGClient(),
      instanceName: 'CBClient',
    );
    gh.lazySingleton<_i3.APIClient>(
      () => _i5.AuthClient(),
      instanceName: 'AuthClient',
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
    gh.lazySingleton<_i13.MessengerCubit>(() => _i13.MessengerCubit());
    gh.factory<_i14.QuizLocalDts>(
        () => _i14.QuizLocalDtsImpl(gh<_i12.HiveLocalStorage>()));
    gh.factory<_i15.QuizRemoteDts>(() =>
        _i15.QuizRemoteDtsImpl(gh<_i3.APIClient>(instanceName: 'CBClient')));
    gh.factory<_i16.QuizRepo>(() => _i17.QuizRepoImpl(
          gh<_i15.QuizRemoteDts>(),
          gh<_i14.QuizLocalDts>(),
        ));
    gh.factory<_i18.SecureStorage>(
        () => _i18.SecureStorageImpl(gh<_i10.FlutterSecureStorage>()));
    gh.factory<_i19.SupabaseConfig>(() => _i19.SupabaseConfigImpl());
    gh.factory<_i20.TransactionRemoteDts>(
        () => _i20.TransactionRemoteDtsImpl());
    gh.factory<_i21.TransactionRepositories>(() =>
        _i22.TransactionRepositoriesImpl(gh<_i20.TransactionRemoteDts>()));
    gh.factory<_i23.AuthenticationLocalDTS>(
        () => _i23.AuthLocalDTSImpl(gh<_i18.SecureStorage>()));
    gh.factory<_i24.AuthenticationRepo>(() => _i25.AuthenticationRepoImpl(
          gh<_i6.AuthenticationRemoteDTS>(),
          gh<_i23.AuthenticationLocalDTS>(),
        ));
    gh.factory<_i26.CachedQuizzes>(
        () => _i26.CachedQuizzes(gh<_i16.QuizRepo>()));
    gh.factory<_i27.CreateTransaction>(
        () => _i27.CreateTransaction(gh<_i21.TransactionRepositories>()));
    gh.factory<_i28.GetCachedQuizzes>(
        () => _i28.GetCachedQuizzes(gh<_i16.QuizRepo>()));
    gh.factory<_i29.GetCurrentSession>(
        () => _i29.GetCurrentSession(gh<_i24.AuthenticationRepo>()));
    gh.factory<_i30.GetQuizData>(() => _i30.GetQuizData(gh<_i16.QuizRepo>()));
    gh.factory<_i31.IncomeTransactionBloc>(() => _i31.IncomeTransactionBloc(
          gh<_i11.GetCategories>(),
          gh<_i27.CreateTransaction>(),
        ));
    gh.factory<_i32.Login>(() => _i32.Login(gh<_i24.AuthenticationRepo>()));
    gh.factory<_i33.LoginBloc>(() => _i33.LoginBloc(gh<_i32.Login>()));
    gh.factory<_i34.Logout>(() => _i34.Logout(gh<_i24.AuthenticationRepo>()));
    gh.factory<_i35.QuizBloc>(() => _i35.QuizBloc(
          gh<_i30.GetQuizData>(),
          gh<_i28.GetCachedQuizzes>(),
          gh<_i26.CachedQuizzes>(),
        ));
    gh.factory<_i36.RegisterUser>(
        () => _i36.RegisterUser(gh<_i24.AuthenticationRepo>()));
    gh.factory<_i37.RegisterUserBloc>(
        () => _i37.RegisterUserBloc(gh<_i36.RegisterUser>()));
    gh.lazySingleton<_i38.SessionBloc>(
        () => _i38.SessionBloc(gh<_i34.Logout>()));
    gh.factory<_i39.SplashCubit>(
        () => _i39.SplashCubit(gh<_i29.GetCurrentSession>()));
    return this;
  }
}

class _$CoreModules extends _i40.CoreModules {}
