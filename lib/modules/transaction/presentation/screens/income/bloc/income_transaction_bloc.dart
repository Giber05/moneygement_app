import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/ext/string_ext.dart';
import 'package:moneygement_app/infrastructure/types/nothing.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/transaction/domain/models/category_model.dart';
import 'package:moneygement_app/modules/transaction/domain/usecases/create_transaction.dart';
import 'package:moneygement_app/modules/transaction/domain/usecases/get_categories.dart';
import 'package:moneygement_app/modules/transaction/presentation/screens/income/create/widgets/create_transaction_formdata.dart';

part 'income_transaction_event.dart';
part 'income_transaction_state.dart';

@injectable
class IncomeTransactionBloc
    extends Bloc<IncomeTransactionEvent, IncomeTransactionState> {
  final GetCategories _getCategories;
  final CreateTransaction _createTransaction;

  IncomeTransactionBloc(this._getCategories, this._createTransaction)
      : super(IncomeTransactionInitial()) {
    on<GetCategoriesEvent>(_onGetCategories);
    on<CreateTransactionEvent>(_onCreateIncome);
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController amountFieldController = TextEditingController();
  final TextEditingController noteFieldCntroller = TextEditingController();

  ValueNotifier<CategoryModel?> selectedCategory =
      ValueNotifier<CategoryModel?>(null);
  ValueNotifier<DateTime?> selectedTransactionDate =
      ValueNotifier<DateTime?>(null);

  Future<void> _onGetCategories(
      GetCategoriesEvent event, Emitter<IncomeTransactionState> emit) async {
    emit(IncomeTransactionLoading());
    final result = await _getCategories(
        GetCategoriesParams(userId: event.userId, type: event.type));
    switch (result) {
      case Success(data: List<CategoryModel> categories):
        categories
            .add(const CategoryModel(id: 0, name: '', type: '', userId: ''));
        emit(IncomeTransactionLoaded(categories: categories));
      case Error():
        emit(IncomeTransactionFailed());
      default:
    }
  }

  Future<void> _onCreateIncome(CreateTransactionEvent event,
      Emitter<IncomeTransactionState> emit) async {
    if (formKey.currentState!.validate()) {
      emit(CreateTransactionLoading(categories: event.categories));
      final amount = amountFieldController.text.parseCurrencyToInt();
      final formRequest = CreateTransactionFormData(
        amount: amount,
        categoryId: selectedCategory.value!.id,
        userId: event.userId,
        transactionDate: selectedTransactionDate.value ?? DateTime.now(),
        transactionType: event.type,
        note: noteFieldCntroller.text,
      );
      print('execute usecase');

      final result =
          await _createTransaction(CreateTransactionParams(formRequest));

      switch (result) {
        case Success(data: Nothing _):
          emit(CreateTransactionSuccess(
              message: 'Berhasil membuat transaksi',
              categories: event.categories));
        case Error():
          emit(CreateTransactionFailed(
              message: result.exception.message, categories: event.categories));
          break;
        default:
      }
    }
  }
}
