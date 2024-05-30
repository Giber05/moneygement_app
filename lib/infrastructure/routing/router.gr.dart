// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:moneygement_app/modules/authentication/presentation/screens/login/login_screen.dart'
    as _i5;
import 'package:moneygement_app/modules/authentication/presentation/screens/register_user/register_user_screen.dart'
    as _i7;
import 'package:moneygement_app/modules/authentication/presentation/screens/splash/splash_screen.dart'
    as _i8;
import 'package:moneygement_app/modules/category/presentation/screens/create_category/create_category_screen.dart'
    as _i1;
import 'package:moneygement_app/modules/home/presentation/screens/home/home_screen.dart'
    as _i4;
import 'package:moneygement_app/modules/quizz/presentation/screens/quiz_screen.dart'
    as _i6;
import 'package:moneygement_app/modules/transaction/presentation/screens/income/create/create_income.dart'
    as _i2;
import 'package:moneygement_app/modules/transaction/presentation/screens/outcome/create/create_outcome.dart'
    as _i3;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    CreateCategoryRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CreateCategoryScreen(),
      );
    },
    CreateIncomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CreateIncomeScreen(),
      );
    },
    CreateOutcomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CreateOutcomeScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginScreen(),
      );
    },
    QuizRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.QuizScreen(),
      );
    },
    RegisterUserRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RegisterUserScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CreateCategoryScreen]
class CreateCategoryRoute extends _i9.PageRouteInfo<void> {
  const CreateCategoryRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CreateCategoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateCategoryRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CreateIncomeScreen]
class CreateIncomeRoute extends _i9.PageRouteInfo<void> {
  const CreateIncomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CreateIncomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateIncomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CreateOutcomeScreen]
class CreateOutcomeRoute extends _i9.PageRouteInfo<void> {
  const CreateOutcomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CreateOutcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateOutcomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.QuizScreen]
class QuizRoute extends _i9.PageRouteInfo<void> {
  const QuizRoute({List<_i9.PageRouteInfo>? children})
      : super(
          QuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.RegisterUserScreen]
class RegisterUserRoute extends _i9.PageRouteInfo<void> {
  const RegisterUserRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RegisterUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterUserRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SplashScreen]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
