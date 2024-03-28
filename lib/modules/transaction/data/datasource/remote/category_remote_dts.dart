import 'package:injectable/injectable.dart';
import 'package:moneygement_app/modules/transaction/data/mapper/remote/request/category_remote_req_mapper.dart';
import 'package:moneygement_app/modules/transaction/data/mapper/remote/response/category_remote_res_mapper.dart';
import 'package:moneygement_app/modules/transaction/domain/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CategoryRemoteDts {
  Future<List<CategoryModel>> getCategories({required String userId, required String transactionType});
  Future<CategoryModel> insertNewCategory(CategoryRemoteReqMapper request);
}

@Injectable(as: CategoryRemoteDts)
class CategoryRemoteDtsImpl implements CategoryRemoteDts {
  final _client = Supabase.instance.client;
  final _categoryMapper = CategoryRemoteResMapper();
  @override
  Future<List<CategoryModel>> getCategories({required String userId, required String transactionType}) async {
    final response = await _client.from('categories').select().eq('user_id', userId).eq('type', transactionType);
    final categories = response.map(_categoryMapper.toModel).toList();
    return categories;
  }

  @override
  Future<CategoryModel> insertNewCategory(CategoryRemoteReqMapper request) {
    // TODO: implement insertNewCategory
    throw UnimplementedError();
  }
}
