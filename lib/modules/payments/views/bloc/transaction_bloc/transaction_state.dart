part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final PaginatedQueryResult<List<Transaction>> transactions;

  const TransactionLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class ErrorLoadingTransaction extends TransactionState {
  final String message;

  const ErrorLoadingTransaction(this.message);

  @override
  List<Object> get props => [message];
}
