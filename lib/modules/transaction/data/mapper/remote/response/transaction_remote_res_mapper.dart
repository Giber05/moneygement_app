import 'package:moneygement_app/infrastructure/types/mapper/json_mapper.dart';
import 'package:moneygement_app/modules/transaction/data/mapper/remote/response/transaction_category_remote_res_mapper.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_model.dart';

class TransactionRemoteResMapper extends FromJSONMapper<TransactionModel> {
  final transactionCategoryMapper = TransactionCategoryRemoteResMapper();
  @override
  TransactionModel toModel(json) {
    return TransactionModel(
      id: json['id'] as int,
      note: json['note'] as String?,
      type: json['type'] as String,
      amount: json['amount'] as int,
      userId: json['user_id'] as String,
      category: transactionCategoryMapper.toModel(json['category']),
      createdAt: DateTime.parse(json['created_at']),
      transactionDate: DateTime.parse(json['transaction_date']),
    );
  }
}
