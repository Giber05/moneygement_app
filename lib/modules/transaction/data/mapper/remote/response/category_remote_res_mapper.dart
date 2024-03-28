import 'package:moneygement_app/infrastructure/types/mapper/json_mapper.dart';
import 'package:moneygement_app/modules/transaction/domain/models/category_model.dart';

class CategoryRemoteResMapper extends FromJSONMapper<CategoryModel> {
  final fields = 'id, name, type, user_id';
  @override
  CategoryModel toModel(json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      userId: json['user_id'],
    );
  }
}
