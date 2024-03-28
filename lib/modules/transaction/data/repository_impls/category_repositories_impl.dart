import 'package:injectable/injectable.dart';
import 'package:moneygement_app/modules/transaction/data/datasource/remote/category_remote_dts.dart';
import 'package:moneygement_app/modules/transaction/data/mapper/remote/request/category_remote_req_mapper.dart';
import 'package:moneygement_app/modules/transaction/domain/models/category_model.dart';
import 'package:moneygement_app/modules/transaction/domain/repositories/category_repositories.dart';

@Injectable(as: CategoryRepo)
class CategoryRepoImpl implements CategoryRepo {
  final CategoryRemoteDts _categoryRemoteDts;

  CategoryRepoImpl(this._categoryRemoteDts);
  @override
  Future<List<CategoryModel>> getCategories({required String userId, required String transactionType}) async {
    return _categoryRemoteDts.getCategories(userId: userId, transactionType: transactionType);
  }

  @override
  Future<CategoryModel> insertNewCategory(CategoryRemoteReqMapper request) {
    // TODO: implement insertNewCategory
    throw UnimplementedError();
  }
}
