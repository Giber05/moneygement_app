// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:moneygement_app/modules/authentication/domain/model/user_model.dart';

class UserSessionModel extends Equatable {
  final String token;
  final UserModel user;
  const UserSessionModel({
    required this.token,
    required this.user,
  });

  @override
  List<Object?> get props => [token];
}
