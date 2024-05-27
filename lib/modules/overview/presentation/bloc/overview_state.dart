part of 'overview_bloc.dart';

sealed class OverviewState extends Equatable {
  const OverviewState();

  @override
  List<Object> get props => [];
}

final class OverviewInitial extends OverviewState {
  const OverviewInitial();
  @override
  List<Object> get props => [];
}

final class OverviewTransactionsLoaded extends OverviewState {
  const OverviewTransactionsLoaded(this.transactions, this.totalTransation);
  final List<TransactionGroupByDate> transactions;

  final int totalTransation;
}

final class OverviewTransactionLoading extends OverviewState {
  const OverviewTransactionLoading();
}

final class OverviewTransactionFilterLoading extends OverviewTransactionsLoaded {
  const OverviewTransactionFilterLoading({
    required List<TransactionGroupByDate> transactions,
    required int totalTransaction,
  }) : super(transactions, totalTransaction);

  @override
  List<Object> get props => [];
}
