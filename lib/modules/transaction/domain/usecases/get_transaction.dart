import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/architecutre/use_case.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_filter.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_model.dart';
import 'package:moneygement_app/modules/transaction/domain/repositories/transaction_repositories.dart';

class GetTransactionParams {
  final GetTransactionFilter filter;

  GetTransactionParams(this.filter);
}

@injectable
class GetTransactions extends Usecase<GetTransactionParams, List<TransactionModel>> {
  final TransactionRepositories _repositories;

  GetTransactions(this._repositories);
  @override
  Future<Resource<List<TransactionModel>>> execute(GetTransactionParams params) async =>
      _repositories.getTransactions(params.filter).asResource;
}
