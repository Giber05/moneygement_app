import 'package:moneygement_app/infrastructure/types/mapper/json_mapper.dart';
import 'package:moneygement_app/modules/authentication/data/mapper/remote/response/user_remote_mapper.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';

class UserSessionRemoteResMapper implements FromJSONMapper<UserSessionModel> {
  @override
  UserSessionModel toModel(json) {
    final userRemoteMapper = UserRemoteResMapper();
    return UserSessionModel(
      token: json["token"],
      user: userRemoteMapper.toModel(json['user'])
    );
  }
}
