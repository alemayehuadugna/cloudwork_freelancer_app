import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/alert_repository.dart';

class SendAlertUseCase implements UseCase<void, NoParams> {
  final AlertRepository repository;

  SendAlertUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.sendNotification();
  }
}
