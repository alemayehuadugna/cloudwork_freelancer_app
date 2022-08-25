import 'package:CloudWork_Freelancer/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:CloudWork_Freelancer/_core/error/failures.dart';

import '../../../../../_core/usecase.dart';
import 'package:equatable/equatable.dart';

class RemoveEmploymentUseCase
    implements UseCase<String, RemoveEmploymentParams> {
  final UserRepository repository;

  RemoveEmploymentUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(RemoveEmploymentParams params) async {
    return await repository.removeEmployment(employmentId: params.employmentId);
  }
}

class RemoveEmploymentParams extends Equatable {
  final String employmentId;

  const RemoveEmploymentParams(
    this.employmentId,
  );

  @override
  List<Object> get props => [employmentId];
}
