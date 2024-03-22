import 'package:moneygement_app/infrastructure/architecutre/local_mapper.dart';
import 'package:moneygement_app/modules/authentication/data/mapper/local/user_local_mapper.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_model.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';

class SessionLocalMapper extends LocalMapper<UserSessionModel, dynamic> {
  SessionLocalMapper();

    final _userLocalMapper = UserLocalMapper();
  @override
  UserSessionModel toDomain(entity) {
    return UserSessionModel(
      token: entity["token"],
      user: _userLocalMapper.toDomain(entity['user'])
    );
  }

  @override
  toEntity(UserSessionModel domain) {
    
    return {
      "token": domain.token,
      "user": _userLocalMapper.toEntity(domain.user),
    };
  }
}
