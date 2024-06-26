import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/messenger/messenger_cubit.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/session/session_bloc.dart';
import 'package:moneygement_app/infrastructure/architecutre/error_handler/global_errror_catcher.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/routing/router.dart';
import 'package:moneygement_app/infrastructure/service_locator/service_locator.dart';
import 'package:moneygement_app/infrastructure/styles/color.dart';
import 'package:moneygement_app/infrastructure/styles/text.dart';

class MoneyGementApp extends StatelessWidget {
  final AppRouter appRouter;
  const MoneyGementApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MessengerCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<SessionBloc>(),
        ),
      ],
      child: Sizer(builder: (context, _, __) {
        return MaterialApp.router(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('id', 'ID'), // Indonesia
          ],
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.delegate(),
          locale: const Locale('id', 'ID'),
          builder: (context, child) {
            return GlobalErrorCatcher(
              child: CBMessengerListener(
                child: child,
              ),
              onSessionExpire: () {
                context.messenger.showErrorSnackbar("Session Expired");
                context.logout();
              },
            );
          },
          routeInformationParser: appRouter.defaultRouteParser(),
          theme: ThemeData(
            useMaterial3: false,
            textTheme: MGTextTheme.textTheme,
            colorScheme: CBTheme.lightScheme,
          ),
        );
      }),
    );
  }
}

class CBMessengerListener extends StatelessWidget {
  final Widget? child;
  const CBMessengerListener({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessengerCubit, MessengerState>(
      listener: (context, state) {
        if (state is MessengerIdle) return;
        if (state is MessengerSnackbar) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: state.backgroundColor(context),
          ));
        }
        context.read<MessengerCubit>().idle();
      },
      child: child,
    );
  }
}
