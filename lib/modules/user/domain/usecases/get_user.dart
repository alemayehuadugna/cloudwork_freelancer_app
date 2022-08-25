import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/basic_user.dart';
import '../repo/user_repository.dart';

class GetBasicUserUseCase implements UseCase<BasicUser, NoParams> {
  final UserRepository repository;

  GetBasicUserUseCase({required this.repository});

  @override
  Future<Either<Failure, BasicUser>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
