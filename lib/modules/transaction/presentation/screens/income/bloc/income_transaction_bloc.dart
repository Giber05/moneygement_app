import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:moneygement_app/infrastructure/types/resource.dart';
import 'package:moneygement_app/modules/transaction/domain/models/category_model.dart';
import 'package:moneygement_app/modules/transaction/domain/usecases/get_categories.dart';

part 'income_transaction_event.dart';
part 'income_transaction_state.dart';

@injectable
class IncomeTransactionBloc extends Bloc<IncomeTransactionEvent, IncomeTransactionState> {
  final GetCategories _getCategories;

  IncomeTransactionBloc(this._getCategories) : super(IncomeTransactionInitial()) {
    on<GetCategoriesEvent>(_onGetCategories);
  }

  Future<void> _onGetCategories(GetCategoriesEvent event, Emitter<IncomeTransactionState> emit) async {
    emit(IncomeTransactionLoading());
    final result = await _getCategories(GetCategoriesParams(userId: event.userId, type: event.type));
    switch (result) {
      case Success(data: List<CategoryModel> categories):
        emit(IncomeTransactionLoaded(categories: categories));
      case Error():
        emit(IncomeTransactionFailed());
      default:
    }
  }
}
