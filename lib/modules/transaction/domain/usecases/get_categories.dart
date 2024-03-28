import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/architecutre/use_case.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/transaction/domain/models/category_model.dart';
import 'package:moneygement_app/modules/transaction/domain/repositories/category_repositories.dart';

class GetCategoriesParams {
  final String userId;
  final String type;

  GetCategoriesParams({required this.userId, required this.type});
}

@injectable
class GetCategories extends Usecase<GetCategoriesParams, List<CategoryModel>> {
  final CategoryRepo _categoryRepo;

  GetCategories(this._categoryRepo);
  @override
  Future<Resource<List<CategoryModel>>> execute(params) async {
    return _categoryRepo.getCategories(userId: params.userId, transactionType: params.type).asResource;
  }
}
