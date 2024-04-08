part of 'income_transaction_bloc.dart';

sealed class IncomeTransactionEvent extends Equatable {
  const IncomeTransactionEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends IncomeTransactionEvent {
  final String userId;
  final String type;

  const GetCategoriesEvent({required this.userId, required this.type});
}

class CreateTransactionEvent extends IncomeTransactionEvent {
  final List<CategoryModel> categories;
  final String type;
  final String userId;
  const CreateTransactionEvent({
    required this.type,
    required this.categories,
    required this.userId,
  });
}
