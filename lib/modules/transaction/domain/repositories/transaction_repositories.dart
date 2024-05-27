import 'package:moneygement_app/infrastructure/types/nothing.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_filter.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_model.dart';
import 'package:moneygement_app/modules/transaction/presentation/screens/income/create/widgets/create_transaction_formdata.dart';

abstract class TransactionRepositories {
  Future<Nothing> createTransaction(CreateTransactionFormData formData);
  Future<List<TransactionModel>> getTransactions(GetTransactionFilter filter);
}
