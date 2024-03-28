part of 'income_transaction_bloc.dart';

sealed class IncomeTransactionState extends Equatable {
  const IncomeTransactionState();

  @override
  List<Object> get props => [];
}

final class IncomeTransactionInitial extends IncomeTransactionState {}

final class IncomeTransactionLoading extends IncomeTransactionState {}

final class IncomeTransactionLoaded extends IncomeTransactionState {
  final List<CategoryModel> categories;

  const IncomeTransactionLoaded({required this.categories});
}

final class IncomeTransactionFailed extends IncomeTransactionState {}
