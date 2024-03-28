// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:moneygement_app/modules/authentication/presentation/screens/login/login_screen.dart'
    as _i3;
import 'package:moneygement_app/modules/authentication/presentation/screens/register_user/register_user_screen.dart'
    as _i5;
import 'package:moneygement_app/modules/authentication/presentation/screens/splash/splash_screen.dart'
    as _i6;
import 'package:moneygement_app/modules/home/presentation/screens/home/home_screen.dart'
    as _i2;
import 'package:moneygement_app/modules/quizz/presentation/screens/quiz_screen.dart'
    as _i4;
import 'package:moneygement_app/modules/transaction/presentation/screens/income/create/create_income.dart'
    as _i1;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    CreateIncomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CreateIncomeScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
      );
    },
    QuizRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.QuizScreen(),
      );
    },
    RegisterUserRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RegisterUserScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CreateIncomeScreen]
class CreateIncomeRoute extends _i7.PageRouteInfo<void> {
  const CreateIncomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          CreateIncomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateIncomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.QuizScreen]
class QuizRoute extends _i7.PageRouteInfo<void> {
  const QuizRoute({List<_i7.PageRouteInfo>? children})
      : super(
          QuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.RegisterUserScreen]
class RegisterUserRoute extends _i7.PageRouteInfo<void> {
  const RegisterUserRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RegisterUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterUserRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SplashScreen]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
