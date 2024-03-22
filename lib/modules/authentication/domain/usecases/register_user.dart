import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/architecutre/use_case.dart';
import 'package:moneygement_app/infrastructure/types/nothing.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/authentication/domain/repositories/authentication_repo.dart';

class RegisterParams {
  final String email;
  final String password;
  final String name;

  RegisterParams({required this.email, required this.password, required this.name});
}

@injectable
class RegisterUser extends Usecase<RegisterParams, Nothing> {
  final AuthenticationRepo _authenticationRepo;

  RegisterUser(this._authenticationRepo);

  @override
  Future<Resource<Nothing>> execute(RegisterParams params) =>
      _authenticationRepo.registerUser(email: params.email, password: params.password, name: params.name).asResource;
}
