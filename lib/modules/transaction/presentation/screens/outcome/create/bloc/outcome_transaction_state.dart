part of 'outcome_transaction_bloc.dart';

sealed class OutcomeTransactionState extends Equatable {
  const OutcomeTransactionState();
  
  @override
  List<Object> get props => [];
}

final class OutcomeTransactionInitial extends OutcomeTransactionState {}

class OutcomeTransactionLoading extends OutcomeTransactionState {}

class OutcomeTransactionLoaded extends OutcomeTransactionState {
  final List<CategoryModel> categories;

  const OutcomeTransactionLoaded({required this.categories});
}

class OutcomeTransactionFailed extends OutcomeTransactionState {}

class CreateOutcomeLoading extends OutcomeTransactionLoaded {
  const CreateOutcomeLoading({required super.categories});
}

class CreateOutcomeSuccess extends OutcomeTransactionLoaded {
  final String message;

  const CreateOutcomeSuccess({required this.message, required super.categories});
}

class CreateOutcomeFailed extends OutcomeTransactionLoaded {
  final String message;
  const CreateOutcomeFailed({
    required this.message,
    required super.categories,
  });
}


