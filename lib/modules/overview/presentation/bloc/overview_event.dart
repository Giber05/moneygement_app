// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'overview_bloc.dart';

sealed class OverviewEvent extends Equatable {
  const OverviewEvent();

  @override
  List<Object> get props => [];
}

class ChangeDateEvent extends OverviewEvent {
  const ChangeDateEvent();
}

class GetTransactionsEvent extends OverviewEvent {
  const GetTransactionsEvent({this.filter});

  final GetTransactionFilter? filter;
}
