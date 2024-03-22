import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String userId;
  final String email;
  final String displayName;

  UserModel({required this.userId, required this.email, required this.displayName});
  
  @override
  List<Object?> get props => [userId, email, displayName];
}
