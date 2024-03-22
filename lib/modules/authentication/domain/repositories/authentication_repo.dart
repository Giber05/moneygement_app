import 'package:moneygement_app/infrastructure/types/nothing.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';

abstract class AuthenticationRepo {
  Future<UserSessionModel> login({required String email, required String password});
  Future<Nothing> registerUser({required String email, required String password, required String name});
  Future<UserSessionModel?> getLastLoggedInUser();
  Future<void> logout();
}
