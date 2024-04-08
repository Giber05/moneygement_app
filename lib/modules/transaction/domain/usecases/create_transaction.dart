
import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/architecutre/use_case.dart';
import 'package:moneygement_app/infrastructure/types/nothing.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/transaction/domain/repositories/transaction_repositories.dart';
import 'package:moneygement_app/modules/transaction/presentation/screens/income/create/widgets/create_transaction_formdata.dart';

class CreateTransactionParams {
  final CreateTransactionFormData formData;

  CreateTransactionParams(this.formData);
}

@injectable
class CreateTransaction extends Usecase<CreateTransactionParams, Nothing> {
  final TransactionRepositories _repo;

  CreateTransaction(this._repo);
  @override
  Future<Resource<Nothing>> execute(CreateTransactionParams params) async =>
      _repo.createTransaction(params.formData).asResource;
}
