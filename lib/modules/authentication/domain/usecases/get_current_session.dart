import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/architecutre/use_case.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/authentication/domain/model/user_session_model.dart';
import 'package:moneygement_app/modules/authentication/domain/repositories/authentication_repo.dart';

@injectable
class GetCurrentSession extends UsecaseNoParams<UserSessionModel?> {
  final AuthenticationRepo _authenticationRepo;

  GetCurrentSession(this._authenticationRepo);

  @override
  Future<Resource<UserSessionModel?>> execute() => _authenticationRepo.getLastLoggedInUser().asResource;
}
