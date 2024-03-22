import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/local_storage/secure_storage/secure_storage.dart';
import 'package:moneygement_app/modules/authentication/data/mapper/local/session_local_mapper.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';

abstract class AuthenticationLocalDTS {
  Future<void> putSession(UserSessionModel session);
  Future<void> clearSession();
  Future<UserSessionModel?> getLastSession();
}

@Injectable(as: AuthenticationLocalDTS)
class AuthLocalDTSImpl implements AuthenticationLocalDTS {
  final SecureStorage _secureStorage;
  final SessionLocalMapper _sessionLocalMapper = SessionLocalMapper();

  final _userSessionKey =
      "cb.quizapp.mobile.lib.modules.authentication.data.datasource.local.authentication_local_dts.dart";

  AuthLocalDTSImpl(this._secureStorage);

  @override
  Future<void> putSession(UserSessionModel session) =>
      _secureStorage.writeJSON(key: _userSessionKey, json: _sessionLocalMapper.toEntity(session));

  @override
  Future<void> clearSession() => _secureStorage.remove(_userSessionKey);

  @override
  Future<UserSessionModel?> getLastSession() =>
      _secureStorage.readData(_sessionLocalMapper.toDomain, key: _userSessionKey);
}
