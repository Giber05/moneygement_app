import 'package:moneygement_app/infrastructure/types/mapper/json_mapper.dart';

class CategoryRemoteReqMapper extends ToJSONMapper<({String name, String type, String userId})> {
  CategoryRemoteReqMapper(super.data);

  @override
  toJSON() {
    return {
      "name": data.name,
      "type": data.type,
      "user_id": data.userId,
    };
  }
}
