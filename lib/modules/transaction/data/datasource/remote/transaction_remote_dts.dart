import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/types/nothing.dart';
import 'package:moneygement_app/modules/transaction/data/mapper/remote/request/create_transaction_remote_req_mapper.dart';
import 'package:moneygement_app/modules/transaction/presentation/screens/income/create/widgets/create_transaction_formdata.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:moneygement_app/infrastructure/types/exceptions/base_exception.dart';

abstract class TransactionRemoteDts {
  Future<Nothing> createTransaction(CreateTransactionFormData formData);
}

@Injectable(as: TransactionRemoteDts)
class TransactionRemoteDtsImpl implements TransactionRemoteDts {
  final _client = Supabase.instance.client;

  @override
  Future<Nothing> createTransaction(CreateTransactionFormData formData) async {
    final CreateTransactionRemoteReqMapper request =
        CreateTransactionRemoteReqMapper((
      amount: formData.amount,
      categoryId: formData.categoryId,
      note: formData.note,
      transactionDate: formData.transactionDate,
      transactionType: formData.transactionType,
      userId: _client.auth.currentUser!.id,
    ));
    print(request.toJSON());
    final response = await _client
        .from('transactions')
        .insert(request.toJSON())
        .select()
        .maybeSingle();

    if (response == null) {
      throw const BaseException('Gagal membuat transaksi');
    }
    return const Nothing();
  }
}
