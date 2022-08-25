import 'package:dartz/dartz.dart';


import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/wallet.dart';
import '../repo/payment_repository.dart';

class GetWalletUseCase implements UseCase<Wallet, NoParams> {
  final PaymentRepository repository;

  GetWalletUseCase({required this.repository});

  @override
  Future<Either<Failure, Wallet>> call(NoParams params) async {
    return await repository.getWallet();
  }
}
