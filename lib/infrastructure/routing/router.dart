import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: RegisterUserRoute.page, path: '/register'),
        AutoRoute(page: SplashRoute.page, path: '/splash', initial: true),
        AutoRoute(page: HomeRoute.page, path: '/home'),
        AutoRoute(page: QuizRoute.page, path: '/quiz'),
        AutoRoute(page: CreateIncomeRoute.page, path: '/create-income'),
        AutoRoute(page: CreateOutcomeRoute.page, path: '/create-outcome'),
        AutoRoute(page: CreateCategoryRoute.page, path: '/create-category'),
      ];
}
