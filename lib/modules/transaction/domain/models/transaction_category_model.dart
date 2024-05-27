import 'package:equatable/equatable.dart';

class TransactionCategoryModel extends Equatable {
  final int id;
  final String name;
  final DateTime? createdAt;

  const TransactionCategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory TransactionCategoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  @override
  List<Object?> get props => [id, name, createdAt];
}
