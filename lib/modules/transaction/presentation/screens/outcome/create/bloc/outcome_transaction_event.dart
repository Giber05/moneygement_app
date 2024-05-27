part of 'outcome_transaction_bloc.dart';

sealed class OutcomeTransactionEvent extends Equatable {
  const OutcomeTransactionEvent();

  @override
  List<Object> get props => [];
}

class GetOutcomeCategoriesEvent extends OutcomeTransactionEvent {
  final String userId;
  final String type;

  const GetOutcomeCategoriesEvent({required this.userId, required this.type});
}

class CreateOutcomeEvent extends OutcomeTransactionEvent {
  final List<CategoryModel> categories;
  final String type;
  final String userId;
  const CreateOutcomeEvent({
    required this.type,
    required this.categories,
    required this.userId,
  });
}
