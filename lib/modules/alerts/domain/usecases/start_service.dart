import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/alert_repository.dart';

class StartAlertService implements UseCase<void, String> {
  final AlertRepository repository;

  StartAlertService({required this.repository});

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.startAlertService(params);
  }
}
