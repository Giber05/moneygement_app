import 'package:auto_route/auto_route.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/session/session_event.dart';
import 'package:moneygement_app/modules/authentication/presentation/screens/login/bloc/login_bloc.dart';
import 'package:moneygement_app/modules/authentication/presentation/screens/login/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/messenger/messenger_cubit.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/session/session_bloc.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/ext/double_ext.dart';
import 'package:moneygement_app/infrastructure/routing/router.gr.dart';
import 'package:moneygement_app/infrastructure/service_locator/service_locator.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:moneygement_app/infrastructure/widgets/form/text_field.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/overlay.dart';

part 'widgets/form.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: Scaffold(
        body: Center(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess) {
                context.read<SessionBloc>().add(SetCurrentUserEvent(state.session));
                context.router.replace(const HomeRoute());
              }
            },
            child: Stack(
              children: [
                const Align(alignment: Alignment.center, child: _LoginForm()),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginError) {
                      context.messenger.showErrorSnackbar(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is! LoginLoading) {
                      return const SizedBox();
                    }
                    return const MGLoadingOverlay();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
