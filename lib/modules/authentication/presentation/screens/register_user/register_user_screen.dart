import 'package:auto_route/auto_route.dart';
import 'package:moneygement_app/modules/authentication/presentation/screens/register_user/bloc/register_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/messenger/messenger_cubit.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/ext/double_ext.dart';
import 'package:moneygement_app/infrastructure/routing/router.gr.dart';
import 'package:moneygement_app/infrastructure/service_locator/service_locator.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:moneygement_app/infrastructure/widgets/form/text_field.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/overlay.dart';

part 'widgets/form.dart';

@RoutePage()
class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterUserBloc>(),
      child: Scaffold(
        body: Center(
          child: BlocListener<RegisterUserBloc, RegisterUserState>(
            listener: (context, state) async {
              if (state is RegisterUserSuccess) {
                context.messenger.showSuccessSnackbar('Registrasi akun berhasil');

                context.router.replace(const LoginRoute());
              } else if (state is RegisterUserFailed) {
                context.messenger.showErrorSnackbar(state.message);
              }
            },
            child: Stack(
              children: [
                const Align(alignment: Alignment.center, child: _RegisterUserForm()),
                BlocConsumer<RegisterUserBloc, RegisterUserState>(
                  listener: (context, state) {
                    if (state is RegisterUserFailed) {
                      context.messenger.showErrorSnackbar(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is! RegisterUserLoading) {
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
