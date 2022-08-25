import 'package:dartz/dartz.dart';

import 'package:CloudWork_Freelancer/_core/error/failures.dart';

import '../../../../_core/usecase.dart';
import '../repo/chat_repository.dart';

class StopSocketService implements UseCase<void, NoParams> {
  final ChatRepository repository;

  StopSocketService({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.dispose();
  }
}
