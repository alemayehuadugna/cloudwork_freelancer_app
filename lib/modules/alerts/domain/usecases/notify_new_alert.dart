import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entity/alert.dart';
import '../repo/alert_repository.dart';

class NotifyNewAlertUseCase implements UseCase<Stream<Alert>, NoParams> {
  final AlertRepository repository;

  NotifyNewAlertUseCase({required this.repository});

  @override
  Future<Either<Failure, Stream<Alert>>> call(NoParams params) async {
    try {
      return Right(repository.newAlert);
    } catch (e) {
      print(e);
      return Left(ServerFailure("message"));
    }
  }
}
