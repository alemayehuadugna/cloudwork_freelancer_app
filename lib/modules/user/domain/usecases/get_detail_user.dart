import 'package:dartz/dartz.dart';

import 'package:CloudWork_Freelancer/_core/error/failures.dart';

import '../../../../_core/usecase.dart';
import '../entities/detail_user.dart';
import '../repo/user_repository.dart';

class GetDetailUserUseCase implements UseCase<DetailUser, NoParams> {
  final UserRepository repository;

  GetDetailUserUseCase({required this.repository});

  @override
  Future<Either<Failure, DetailUser>> call(NoParams params) async {
    return await repository.getDetailUser();
  }
}
