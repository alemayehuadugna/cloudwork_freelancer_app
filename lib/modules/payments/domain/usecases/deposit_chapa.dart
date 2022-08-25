import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/payment_repository.dart';

class DepositChapaUseCase implements UseCase<String, double> {
  final PaymentRepository repository;

  DepositChapaUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(double params) async {
    return await repository.depositWithChapa(params);
  }
}
