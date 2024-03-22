import 'package:moneygement_app/infrastructure/types/mapper/json_mapper.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_model.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';

class UserRemoteResMapper implements FromJSONMapper<UserModel> {
  @override
  UserModel toModel(json) {
    
    return UserModel(
       userId: json['user_id'],
       email: json['email'],
       displayName: json['name']
    );
  }
}