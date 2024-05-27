import 'package:moneygement_app/infrastructure/types/mapper/json_mapper.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_category_model.dart';

class TransactionCategoryRemoteResMapper extends FromJSONMapper<TransactionCategoryModel> {
  @override
  TransactionCategoryModel toModel(json) {
    return TransactionCategoryModel(
       id: json['id'] as int,
      name: json['name'] as String,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }
}