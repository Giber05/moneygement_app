import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/architecutre/blocs/messenger/messenger_cubit.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_filter.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_group_by_date.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_model.dart';
import 'package:moneygement_app/modules/transaction/domain/usecases/get_transaction.dart';

part 'overview_event.dart';
part 'overview_state.dart';

@injectable
class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final GetTransactions _getTransactions;
  final MessengerCubit _messengerCubit;
  OverviewBloc(this._getTransactions, this._messengerCubit) : super(const OverviewInitial()) {
    on<ChangeDateEvent>(_onChangeSelectedDate);
    on<GetTransactionsEvent>(_onGetTransactions);
  }

  Future<void> _onChangeSelectedDate(ChangeDateEvent event, Emitter<OverviewState> emit) async {
    final currentState = state;
    if (currentState is OverviewTransactionsLoaded) {
      // emit(SelectedDateChanged(event.selectedDate));
    }
  }

  Future<void> _onGetTransactions(GetTransactionsEvent event, Emitter<OverviewState> emit) async {
    final currentState = state;
    if (currentState is OverviewTransactionsLoaded) {
      emit(OverviewTransactionFilterLoading(
          transactions: currentState.transactions, totalTransaction: currentState.totalTransation));
    } else {
      emit(const OverviewTransactionLoading());
    }
    final result = await _getTransactions(
      GetTransactionParams(
        event.filter ??
            GetTransactionFilter(
              month: DateTime.now().month,
              year: DateTime.now().year,
            ),
      ),
    );
    switch (result) {
      case Success(data: List<TransactionModel> transactions):
        Map<DateTime, List<TransactionModel>> groupedTransactions = {};
        for (var transaction in transactions) {
          DateTime date = transaction.transactionDate;

          if (!groupedTransactions.containsKey(date)) {
            groupedTransactions[date] = [];
          }

          groupedTransactions[date]?.add(transaction);
        }
        final listData = groupedTransactions.entries.map((entry) {
          return TransactionGroupByDate(transactionDate: entry.key, transactions: entry.value);
        }).toList();

        emit(OverviewTransactionsLoaded(listData, transactions.length));

        break;
      case Error():
        _messengerCubit.showErrorSnackbar(result.exception.message);
    }
  }
}
