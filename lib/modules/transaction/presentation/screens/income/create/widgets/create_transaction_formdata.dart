// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateTransactionFormData {
  int amount;
  int categoryId;
  String userId;
  String? note;
  DateTime transactionDate;
  String transactionType;
  CreateTransactionFormData({
    required this.amount,
    required this.categoryId,
    required this.userId,
    this.note,
    required this.transactionDate,
    required this.transactionType,
  });
}
