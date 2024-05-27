import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneygement_app/infrastructure/ext/date_ext.dart';
import 'package:moneygement_app/infrastructure/ext/double_ext.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/circular.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/overlay.dart';
import 'package:moneygement_app/modules/overview/presentation/bloc/overview_bloc.dart';
import 'package:moneygement_app/modules/overview/presentation/widgets/month_picker.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_filter.dart';

// ignore: must_be_immutable
class ListOverview extends StatelessWidget {
  ListOverview({super.key});

  ValueNotifier<DateTime> selectedDate = ValueNotifier<DateTime>(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OverviewBloc, OverviewState>(
      builder: (context, state) {
        if (state is OverviewTransactionLoading) {
          return const Center(
            child: CBCircularLoading(),
          );
        }
        if (state is OverviewTransactionsLoaded) {
          final bloc = context.read<OverviewBloc>();
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: ValueListenableBuilder(
                    valueListenable: selectedDate,
                    builder: (context, date, _) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MonthPicker(
                                  subTitle: '${state.totalTransation} Transaction',
                                  onMonthChanged: (value) {
                                    selectedDate.value = value;
                                    bloc.add(
                                      GetTransactionsEvent(
                                        filter: GetTransactionFilter(
                                          month: selectedDate.value.month,
                                          year: selectedDate.value.year,
                                        ),
                                      ),
                                    );
                                  },
                                  currentDate: date,
                                ),
                              ),
                              8.horizontalSpace,
                              InkWell(
                                onTap: () {
                                  bloc.add(
                                    GetTransactionsEvent(
                                      filter: GetTransactionFilter(
                                        month: selectedDate.value.month,
                                        year: selectedDate.value.year,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    border: Border.all(),
                                  ),
                                  child: const Icon(Icons.refresh_rounded),
                                ),
                              )
                            ],
                          ),
                          16.verticalSpace,
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                bloc.add(
                                  GetTransactionsEvent(
                                    filter: GetTransactionFilter(
                                      month: selectedDate.value.month,
                                      year: selectedDate.value.year,
                                    ),
                                  ),
                                );
                              },
                              child: ListView.builder(
                                  itemCount: state.transactions.length,
                                  itemBuilder: (context, index) {
                                    final item = state.transactions[index];
                                    return ExpansionTile(
                                      initiallyExpanded: true,
                                      title: Text(item.transactionDate.dateStringForm()),
                                      children: item.transactions.map((transaction) {
                                        return ListTile(
                                          title: Text(transaction.note ?? ''),
                                          subtitle: Text(
                                            '${transaction.category.name} - ${transaction.amount.currencyFormat()}',
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }),
                            ),
                          )
                        ],
                      );
                    }),
              ),
              if (state is OverviewTransactionFilterLoading) const MGLoadingOverlay()
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
