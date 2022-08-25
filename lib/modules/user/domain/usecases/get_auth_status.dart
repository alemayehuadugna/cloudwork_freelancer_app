import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/user_repository.dart';

class GetAuthStatusUseCase implements UseCase<bool, NoParams> {
  final UserRepository repository;

  GetAuthStatusUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isAuthenticated();
  }
}
