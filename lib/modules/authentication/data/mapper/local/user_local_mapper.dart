import 'package:moneygement_app/infrastructure/architecutre/local_mapper.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_model.dart';

class UserLocalMapper extends LocalMapper<UserModel, dynamic> {
  UserLocalMapper();

  @override
  UserModel toDomain(entity) {
    return UserModel(userId: entity['user_id'], email: entity['email'], displayName: entity['display_name']);
  }

  @override
  toEntity(UserModel domain) {
    return {
      "user_id": domain.userId,
      "email": domain.email,
      "display_name": domain.displayName,
    };
  }
}
