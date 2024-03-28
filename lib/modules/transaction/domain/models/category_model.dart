// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String type;
  final String userId;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, name, type, userId];
}
