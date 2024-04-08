import 'package:moneygement_app/infrastructure/types/mapper/json_mapper.dart';

class CreateTransactionRemoteReqMapper extends ToJSONMapper<
    ({
      int amount,
      String transactionType,
      String userId,
      String? note,
      int categoryId,
      DateTime transactionDate
    })> {
  CreateTransactionRemoteReqMapper(super.data);

  @override
  toJSON() {
    return {
      "amount": data.amount,
      "type": data.transactionType,
      "user_id": data.userId,
      "category_id": data.categoryId,
      "transaction_date": data.transactionDate.toIso8601String(),
      "created_at": DateTime.now().toIso8601String(),
      "note": data.note,
      "updated_at": null,
    };
  }
}
