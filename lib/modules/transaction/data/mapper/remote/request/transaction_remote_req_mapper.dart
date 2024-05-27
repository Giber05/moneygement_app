import 'package:moneygement_app/infrastructure/types/mapper/json_mapper.dart';

class TransactionRemoteReqMapper extends ToJSONMapper<
    ({
      int? categoryId,
      int? month,
      int? year,
      String? keywords,
      String? transactionType,
    })> {
  TransactionRemoteReqMapper(super.data);

  @override
  toJSON() {
    return {
      'filter_year': data.year,
      'filter_month': data.month,
      'filter_transaction_type': data.transactionType,
      'filter_category_id': data.categoryId,
      'search_query': data.keywords,
    };
  }
}
