import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/transaction.dart';
import '../repo/payment_repository.dart';

class WithdrawUseCase implements UseCase<void, WithdrawParams> {
  final PaymentRepository repository;

  WithdrawUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(WithdrawParams params) async {
    return await repository.withdraw(params.amount, params.tnxBy);
  }
}

class WithdrawParams extends Equatable {
  final double amount;
  final TransactionBy tnxBy;

  const WithdrawParams(this.amount, this.tnxBy);

  @override
  List<Object> get props => [amount, tnxBy];
}
