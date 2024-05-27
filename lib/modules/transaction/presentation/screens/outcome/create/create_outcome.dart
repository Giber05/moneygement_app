import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_route/auto_route.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/messenger/messenger_cubit.dart';
import 'package:moneygement_app/infrastructure/ext/color_ext.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/ext/double_ext.dart';
import 'package:moneygement_app/infrastructure/ext/shadow_ext.dart';
import 'package:moneygement_app/infrastructure/service_locator/service_locator.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:moneygement_app/infrastructure/widgets/form/date_time/date_picker.dart';
import 'package:moneygement_app/infrastructure/widgets/form/text_field.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/circular.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/overlay.dart';
import 'package:moneygement_app/modules/transaction/domain/models/category_model.dart';
import 'package:moneygement_app/modules/transaction/presentation/screens/outcome/create/bloc/outcome_transaction_bloc.dart';
import 'package:sizer/sizer.dart';

part 'widgets/create_outcome_form.dart';

@RoutePage()
class CreateOutcomeScreen extends StatelessWidget {
  const CreateOutcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OutcomeTransactionBloc>()
        ..add(GetOutcomeCategoriesEvent(
            userId: context.userSession.user.userId, type: 'OUTCOME')),
      child: Scaffold(
        backgroundColor: context.color.background,
        body: const _CreateOutcomeBody(),
      ),
    );
  }
}

class _CreateOutcomeBody extends StatelessWidget {
  const _CreateOutcomeBody();

  @override
  Widget build(BuildContext context) {
    print('build outcome form body');
    return BlocConsumer<OutcomeTransactionBloc, OutcomeTransactionState>(
      listener: (context, state) {
        final messengerCubit = context.read<MessengerCubit>();
        if (state is CreateOutcomeSuccess) {
          messengerCubit.showSuccessSnackbar(state.message);
        }
        if (state is CreateOutcomeSuccess) {
          messengerCubit.showErrorSnackbar(state.message);
        }
      },
      builder: (context, state) => Stack(
        children: [
          Container(
            height: 25.h,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 42),
            decoration: BoxDecoration(
                gradient: context.color.primaryToSecondaryGradient,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(16),
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    context.router.maybePop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: context.color.background,
                  ),
                ),
                Text(
                  'Pengeluaran Baru',
                  style: context.text.titleLarge
                      ?.copyWith(color: context.color.background),
                ),
              ],
            ),
          ),
          BlocBuilder<OutcomeTransactionBloc, OutcomeTransactionState>(
            builder: (context, state) {
              if (state is OutcomeTransactionLoading) {
                return const Center(
                  child: CBCircularLoading(),
                );
              }
              if (state is OutcomeTransactionFailed) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Failed to get data!',
                      style: context.text.bodyLarge
                          ?.copyWith(color: context.color.error),
                    ),
                  ],
                );
              }
              if (state is OutcomeTransactionLoaded) {
                return _CreateOutcomeForm(
                  categories: state.categories,
                );
              }
              return const SizedBox();
            },
          ),
          if (state is CreateOutcomeLoading) const MGLoadingOverlay()
        ],
      ),
    );
  }
}
