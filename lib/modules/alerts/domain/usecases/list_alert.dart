import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entity/alert.dart';
import '../repo/alert_repository.dart';

class ListAlertUseCase implements UseCase<Stream<List<Alert>>, NoParams> {
  final AlertRepository repository;

  ListAlertUseCase({required this.repository});
  @override
  Future<Either<Failure, Stream<List<Alert>>>> call(NoParams params) async {
    try {
      return Right(repository.notifications);
    } catch (e) {
      return Left(ServerFailure("couldn't load notifications"));
    }
  }
}
