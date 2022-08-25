import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecase.dart';
import '../../repo/user_repository.dart';

class RemoveEducationUseCase implements UseCase<String, RemoveEducationParams> {
  final UserRepository repository;

  RemoveEducationUseCase({required this.repository});
  @override
  Future<Either<Failure, String>> call(RemoveEducationParams params) async {
    return await repository.removeEducation(educationId: params.educationId);
  }
}

class RemoveEducationParams extends Equatable {
  final String educationId;

  const RemoveEducationParams(
    this.educationId,
  );

  @override
  List<Object> get props => [educationId];
}
