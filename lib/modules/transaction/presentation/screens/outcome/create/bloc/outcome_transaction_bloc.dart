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

part 'outcome_transaction_event.dart';
part 'outcome_transaction_state.dart';

@injectable
class OutcomeTransactionBloc
    extends Bloc<OutcomeTransactionEvent, OutcomeTransactionState> {
  final GetCategories _getCategories;
  final CreateTransaction _createTransaction;

OutcomeTransactionBloc(this._getCategories, this._createTransaction)
    : super(OutcomeTransactionInitial()) {
  on<GetOutcomeCategoriesEvent>(_onGetCategories);
  on<CreateOutcomeEvent>(_onCreateOutcome);
}


  final formKey = GlobalKey<FormState>();

  final TextEditingController amountFieldController = TextEditingController();
  final TextEditingController noteFieldCntroller = TextEditingController();

  ValueNotifier<CategoryModel?> selectedCategory =
      ValueNotifier<CategoryModel?>(null);
  ValueNotifier<DateTime?> selectedTransactionDate =
      ValueNotifier<DateTime?>(null);

  Future<void> _onGetCategories(GetOutcomeCategoriesEvent event,
      Emitter<OutcomeTransactionState> emit) async {
    print('GET CATEGORIES IN OUTCOME');
    emit(OutcomeTransactionLoading());
    final result = await _getCategories(
        GetCategoriesParams(userId: event.userId, type: event.type));
    switch (result) {
      case Success(data: List<CategoryModel> categories):
        categories
            .add(const CategoryModel(id: 0, name: '', type: '', userId: ''));
        emit(OutcomeTransactionLoaded(categories: categories));
      case Error():
        emit(OutcomeTransactionFailed());
      default:
    }
  }

  Future<void> _onCreateOutcome(
      CreateOutcomeEvent event, Emitter<OutcomeTransactionState> emit) async {
    if (formKey.currentState!.validate()) {
      emit(CreateOutcomeLoading(categories: event.categories));
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
          emit(CreateOutcomeSuccess(
              message: 'Berhasil membuat transaksi',
              categories: event.categories));
        case Error():
          emit(CreateOutcomeFailed(
              message: result.exception.message, categories: event.categories));
          break;
        default:
      }
    }
  }
}
