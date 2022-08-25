part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class ListTransactionsEvent extends TransactionEvent {
  final dynamic pagination;
  final dynamic filter;
  final dynamic sort;

  const ListTransactionsEvent({this.pagination, this.filter, this.sort});
  @override
  List<Object> get props => [];
}
