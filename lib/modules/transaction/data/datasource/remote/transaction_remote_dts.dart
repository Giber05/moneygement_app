import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/types/nothing.dart';
import 'package:moneygement_app/modules/transaction/data/mapper/remote/request/create_transaction_remote_req_mapper.dart';
import 'package:moneygement_app/modules/transaction/data/mapper/remote/request/transaction_remote_req_mapper.dart';
import 'package:moneygement_app/modules/transaction/data/mapper/remote/response/transaction_remote_res_mapper.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_filter.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_model.dart';
import 'package:moneygement_app/modules/transaction/presentation/screens/income/create/widgets/create_transaction_formdata.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:moneygement_app/infrastructure/types/exceptions/base_exception.dart';

abstract class TransactionRemoteDts {
  Future<Nothing> createTransaction(CreateTransactionFormData formData);
  Future<List<TransactionModel>> getTransactions(GetTransactionFilter filter);
}

@Injectable(as: TransactionRemoteDts)
class TransactionRemoteDtsImpl implements TransactionRemoteDts {
  final _client = Supabase.instance.client;

  final _transactionMapper = TransactionRemoteResMapper();

  @override
  Future<Nothing> createTransaction(CreateTransactionFormData formData) async {
    final CreateTransactionRemoteReqMapper request = CreateTransactionRemoteReqMapper((
      amount: formData.amount,
      categoryId: formData.categoryId,
      note: formData.note,
      transactionDate: formData.transactionDate,
      transactionType: formData.transactionType,
      userId: _client.auth.currentUser!.id,
    ));
    final response = await _client.from('transactions').insert(request.toJSON()).select().maybeSingle();

    if (response == null) {
      throw const BaseException('Gagal membuat transaksi');
    }
    return const Nothing();
  }

  @override
  Future<List<TransactionModel>> getTransactions(GetTransactionFilter filter) async {
    final reqMapper = TransactionRemoteReqMapper((
      categoryId: filter.categoryId,
      keywords: filter.keywords,
      month: filter.month,
      transactionType: filter.transactionType,
      year: filter.year
    ));
    final params = reqMapper.toJSON();
    final response = await _client.rpc(
      'get_transactions',
      params: params,
    );
    if (response == null) {
      print('Error fetching data: ${response}');
      return [];
    }
    print('Suksess: ${response}');
    final transactions = (response as List<dynamic>).map((e) => _transactionMapper.toModel(e)).toList();
    return transactions;
  }
}
