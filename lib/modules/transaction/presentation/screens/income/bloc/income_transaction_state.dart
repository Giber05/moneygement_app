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

class CreateIncomeLoading extends IncomeTransactionLoaded {
  const CreateIncomeLoading({required super.categories});
}

class CreateIncomeSuccess extends IncomeTransactionLoaded {
  final String message;

  const CreateIncomeSuccess({required this.message, required super.categories});
}

class CreateIncomeFailed extends IncomeTransactionLoaded {
  final String message;
  const CreateIncomeFailed({
    required this.message,
    required super.categories,
  });
}
