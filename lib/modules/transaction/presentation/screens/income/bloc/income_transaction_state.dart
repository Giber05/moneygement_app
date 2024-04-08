// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'income_transaction_bloc.dart';

sealed class IncomeTransactionState extends Equatable {
  const IncomeTransactionState();

  @override
  List<Object> get props => [];
}

class IncomeTransactionInitial extends IncomeTransactionState {}

class IncomeTransactionLoading extends IncomeTransactionState {}

class IncomeTransactionLoaded extends IncomeTransactionState {
  final List<CategoryModel> categories;

  const IncomeTransactionLoaded({required this.categories});
}

class IncomeTransactionFailed extends IncomeTransactionState {}

class CreateTransactionLoading extends IncomeTransactionLoaded {
  const CreateTransactionLoading({required super.categories});
}

class CreateTransactionSuccess extends IncomeTransactionLoaded {
  final String message;

  const CreateTransactionSuccess(
      {required this.message, required super.categories});
}

class CreateTransactionFailed extends IncomeTransactionLoaded {
  final String message;
  const CreateTransactionFailed({
    required this.message,
    required super.categories,
  });
}
