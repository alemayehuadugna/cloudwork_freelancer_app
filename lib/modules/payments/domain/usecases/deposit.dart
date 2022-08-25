import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/transaction.dart';
import '../repo/payment_repository.dart';

class DepositUseCase implements UseCase<void, DepositParams> {
  final PaymentRepository repository;

  DepositUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(DepositParams params) async {
    return await repository.deposit(
      params.amount,
      params.tnxBy,
      params.tnxNumber,
    );
  }
}

class DepositParams extends Equatable {
  final double amount;
  final TransactionBy tnxBy;
  final String tnxNumber;

  const DepositParams(this.amount, this.tnxBy, this.tnxNumber);

  @override
  List<Object> get props => [amount, tnxBy, tnxNumber];
}
