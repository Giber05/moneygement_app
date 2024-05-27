import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetTransactionFilter extends Equatable {
  int? categoryId;
  int? month;
  int? year;
  String? keywords;
  String? transactionType;
  GetTransactionFilter({
     this.categoryId,
     this.month,
     this.year,
     this.keywords,
     this.transactionType,
  });
  
  @override
  List<Object?> get props => [categoryId, month, year, keywords, transactionType];

  
}
