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
import 'package:moneygement_app/infrastructure/routing/router.gr.dart';
import 'package:moneygement_app/infrastructure/service_locator/service_locator.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:moneygement_app/infrastructure/widgets/form/date_time/date_picker.dart';
import 'package:moneygement_app/infrastructure/widgets/form/text_field.dart';
import 'package:moneygement_app/infrastructure/widgets/layouts/dialog/dialog_container.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/circular.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/overlay.dart';
import 'package:moneygement_app/modules/transaction/domain/models/category_model.dart';
import 'package:moneygement_app/modules/transaction/presentation/screens/income/bloc/income_transaction_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
part 'widgets/create_income_form.dart';

@RoutePage()
class CreateIncomeScreen extends StatelessWidget {
  const CreateIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<IncomeTransactionBloc>()
        ..add(GetCategoriesEvent(userId: context.userSession.user.userId, type: 'INCOME')),
      child: Scaffold(
        backgroundColor: context.color.background,
        body: const _CreateTransactionBody(),
      ),
    );
  }
}

class _CreateTransactionBody extends StatelessWidget {
  const _CreateTransactionBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncomeTransactionBloc, IncomeTransactionState>(
      listener: (context, state) {
        final messengerCubit = context.read<MessengerCubit>();
        if (state is CreateIncomeSuccess) {
          messengerCubit.showSuccessSnackbar(state.message);
          context.router.maybePop();
        }
        if (state is CreateIncomeSuccess) {
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
                  'Pemasukan Baru',
                  style: context.text.titleLarge?.copyWith(color: context.color.background),
                ),
              ],
            ),
          ),
          BlocBuilder<IncomeTransactionBloc, IncomeTransactionState>(
            builder: (context, state) {
              if (state is IncomeTransactionLoading) {
                return const Center(
                  child: CBCircularLoading(),
                );
              }
              if (state is IncomeTransactionFailed) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Failed to get data!',
                      style: context.text.bodyLarge?.copyWith(color: context.color.error),
                    ),
                  ],
                );
              }
              if (state is IncomeTransactionLoaded) {
                return _CreateIncomeForm(
                  categories: state.categories,
                );
              }
              return const SizedBox();
            },
          ),
          if (state is CreateIncomeLoading) const MGLoadingOverlay()
        ],
      ),
    );
  }
}
