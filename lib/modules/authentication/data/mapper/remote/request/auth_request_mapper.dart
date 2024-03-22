import 'package:moneygement_app/infrastructure/types/mapper/json_mapper.dart';

class AuthRemoteReqMapper extends ToJSONMapper<({String email, String password})> {
  AuthRemoteReqMapper(super.data);

  @override
  toJSON() {
    return {
      "password": data.password,
      "email": data.email,
    };
  }
}
