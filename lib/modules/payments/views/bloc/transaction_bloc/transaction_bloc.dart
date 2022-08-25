import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/cqrs.dart';
import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecase.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/usecases/list_transactions.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final ListTransactionsUseCase _listTransactions;

  TransactionBloc({
    required ListTransactionsUseCase listTransactionsUseCase,
  })  : _listTransactions = listTransactionsUseCase,
        super(TransactionInitial()) {
    on<ListTransactionsEvent>(_listTransactionsEvent);
  }

  void _listTransactionsEvent(
    ListTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    print("bloc event: ${event.pagination}");
    final result = await _listTransactions(
      QueryParams(event.pagination, event.filter, event.sort),
    );
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorLoadingTransaction(error.message);
        }
        return const ErrorLoadingTransaction('Error Loading Transactions');
      },
      (transactions) => TransactionLoaded(transactions),
    ));
  }
}
