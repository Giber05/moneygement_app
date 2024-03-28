import 'package:moneygement_app/modules/transaction/data/mapper/remote/request/category_remote_req_mapper.dart';
import 'package:moneygement_app/modules/transaction/domain/models/category_model.dart';

abstract class CategoryRepo {
  Future<List<CategoryModel>> getCategories({required String userId, required String transactionType});
  Future<CategoryModel> insertNewCategory(CategoryRemoteReqMapper request);
}
