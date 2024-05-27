import 'package:equatable/equatable.dart';
import 'package:moneygement_app/modules/transaction/domain/models/transaction_category_model.dart';

class TransactionModel extends Equatable {
  final int id;
  final String? note;
  final String type;
  final int amount;
  final String userId;
  final TransactionCategoryModel category;
  final DateTime createdAt;
  final DateTime transactionDate;

  const TransactionModel({
    required this.id,
    required this.note,
    required this.type,
    required this.amount,
    required this.userId,
    required this.category,
    required this.createdAt,
    required this.transactionDate,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int,
      note: json['note'] as String?,
      type: json['type'] as String,
      amount: json['amount'] as int,
      userId: json['user_id'] as String,
      category: TransactionCategoryModel.fromJson(json['category']),
      createdAt: DateTime.parse(json['created_at']),
      transactionDate: DateTime.parse(json['transaction_date']),
    );
  }

  @override
  List<Object?> get props =>
      [id, note, type, amount, userId, category, createdAt, transactionDate];
}

