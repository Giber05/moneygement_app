import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/types/nothing.dart';
import 'package:moneygement_app/modules/transaction/data/datasource/remote/transaction_remote_dts.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_filter.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_model.dart';
import 'package:moneygement_app/modules/transaction/domain/repositories/transaction_repositories.dart';
import 'package:moneygement_app/modules/transaction/presentation/screens/income/create/widgets/create_transaction_formdata.dart';

@Injectable(as: TransactionRepositories)
class TransactionRepositoriesImpl implements TransactionRepositories {
  final TransactionRemoteDts _remoteDts;

  TransactionRepositoriesImpl(this._remoteDts);
  @override
  Future<Nothing> createTransaction(CreateTransactionFormData formData) async => _remoteDts.createTransaction(formData);

  @override
  Future<List<TransactionModel>> getTransactions(GetTransactionFilter filter) => _remoteDts.getTransactions(filter);
}
