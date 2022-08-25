import 'package:dartz/dartz.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/transaction.dart';
import '../repo/payment_repository.dart';

class ListTransactionsUseCase
    implements UseCase<PaginatedQueryResult<List<Transaction>>, QueryParams> {
  final PaymentRepository repository;

  ListTransactionsUseCase({required this.repository});

  @override
  Future<Either<Failure, PaginatedQueryResult<List<Transaction>>>> call(
      QueryParams params) async {
    print("usecase pagination: ${params.pagination}");
    return await repository.listTransactions(
        pagination: params.pagination,
        sort: params.sort,
        filter: params.filter);
  }
}
