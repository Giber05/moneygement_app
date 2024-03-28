import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_route/auto_route.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneygement_app/infrastructure/ext/color_ext.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/ext/double_ext.dart';
import 'package:moneygement_app/infrastructure/ext/shadow_ext.dart';
import 'package:moneygement_app/infrastructure/service_locator/service_locator.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:moneygement_app/infrastructure/widgets/form/date_time/date_picker.dart';
import 'package:moneygement_app/infrastructure/widgets/form/dropdown.dart';
import 'package:moneygement_app/infrastructure/widgets/form/text_field.dart';
import 'package:moneygement_app/infrastructure/widgets/layouts/bottom_sheet/bottom_sheet.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/circular.dart';
import 'package:moneygement_app/modules/transaction/domain/models/category_model.dart';
import 'package:moneygement_app/modules/transaction/presentation/screens/income/bloc/income_transaction_bloc.dart';
import 'package:sizer/sizer.dart';

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
        body: Stack(children: [
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
                return Container(
                  margin: EdgeInsets.only(top: 12.h),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            color: context.color.onPrimary,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadowExtension.medium()]),
                        child: Column(
                          children: [
                            20.verticalSpace,
                            TextFormField(
                              style: context.text.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold, color: context.color.onSurface),
                              textAlign: TextAlign.center,
                              inputFormatters: <TextInputFormatter>[
                                CurrencyTextInputFormatter(
                                  locale: 'id',
                                  symbol: 'Rp. ',
                                  decimalDigits: 0,
                                ),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Rp.0', enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
                            ),
                            16.verticalSpace,
                            CustomDropdown<CategoryModel>.search(
                              items: state.categories,
                              onChanged: (value) {},
                              
                            ),
                            16.verticalSpace,
                            MGDatePicker(
                              onFieldSubmitted: (DateTime? newValue) {},
                              borderRadius: null,
                              enabled: true,
                            ),
                            16.verticalSpace,
                            MGTextField(
                              label: 'Catatan',
                            )
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      MGElevatedButton(
                        label: 'Simpan',
                        elevation: 2,
                        fillParent: true,
                        onPressed: () {
                          openBottomSheet(context: context);
                        },
                      )
                    ],
                  )),
                );
              }
              return const SizedBox();
            },
          )
        ]),
      ),
    );
  }
}
