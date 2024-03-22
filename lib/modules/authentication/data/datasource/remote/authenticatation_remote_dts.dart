import 'package:moneygement_app/infrastructure/types/exceptions/base_exception.dart';
import 'package:moneygement_app/infrastructure/types/nothing.dart';
import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/http_client/api_client.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_model.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthenticationRemoteDTS {
  Future<APIResult<UserSessionModel>> login({required String email, required String password});
  Future<APIResult<Nothing>> registerUser({required String email, required String password, required String name});

  Future<APIResult<Nothing>> logout();
}

@Injectable(as: AuthenticationRemoteDTS)
class AuthenticationRemoteDTSImpl implements AuthenticationRemoteDTS {
  final SupabaseClient _supabase = Supabase.instance.client;

  AuthenticationRemoteDTSImpl();

  @override
  Future<APIResult<UserSessionModel>> login({required String email, required String password}) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user != null) {
        final user = response.user;
        final session = response.session;
        return APIResult(
            data: UserSessionModel(
                token: session!.accessToken,
                user: UserModel(userId: user!.id, email: email, displayName: user.userMetadata?["name"])),
            message: "Login berhasil",
            status: "OK",
            code: 200);
      }
      throw BaseException.unknownError();
    } on AuthException catch (e) {
      if (e.statusCode == '400') {
        throw BaseException(e.message);
      }

      rethrow;
    }
  }

  @override
  Future<APIResult<Nothing>> logout() => throw UnimplementedError();
  // _supabase.post(
  //       path: '/logout',
  //       shouldPrint: true,
  //       body: {},
  //       mapper: (json) => const Nothing(),
  //     );

  @override
  Future<APIResult<Nothing>> registerUser(
      {required String email, required String password, required String name}) async {
    try {
      final response = await _supabase.auth.signUp(
        password: password,
        email: email,
        data: {"name": name},
      );
      if (response.user != null) {
        return const APIResult(
          data: Nothing(),
          message: "Registrasi akun berhasil!",
          status: "OK",
          code: 200,
        );
      }

      throw BaseException.unknownError();
    } on AuthException catch (e) {
      BaseException(e.message);
      rethrow;
    }
  }
  // throw UnimplementedError();

  // _supabase.post(
  //     path: '/register',
  //     shouldPrint: true,
  //     body: AuthRemoteReqMapper((password: password, email: email)).toJSON(),
  //     mapper: (json) => UserSessionRemoteResMapper().toModel(json));
}
