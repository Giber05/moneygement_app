import 'package:equatable/equatable.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_model.dart';

class TransactionGroupByDate extends Equatable {
  final DateTime transactionDate;
  final List<TransactionModel> transactions;

  const TransactionGroupByDate({required this.transactionDate, required this.transactions});
  
  @override
  List<Object?> get props => [transactionDate, transactions];
}
