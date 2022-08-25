import 'package:dartz/dartz.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_core/error/failures.dart';
import '../entities/transaction.dart';
import '../entities/wallet.dart';

abstract class PaymentRepository {
  Future<Either<Failure, Wallet>> getWallet();
  Future<Either<Failure, PaginatedQueryResult<List<Transaction>>>>
      listTransactions({pagination, filter, sort});
  Future<Either<Failure, void>> deposit(
    double amount,
    TransactionBy tnxBy,
    String tnxNumber,
  );
  Future<Either<Failure, void>> withdraw(
    double amount,
    TransactionBy tnxBy,
  );

  Future<Either<Failure, String>> depositWithChapa(double amount);
}
