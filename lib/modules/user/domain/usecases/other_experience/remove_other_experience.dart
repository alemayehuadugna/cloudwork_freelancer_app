import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecase.dart';
import '../../repo/user_repository.dart';

class RemoveOtherExperienceUseCase
    implements UseCase<void, RemoveOtherExperienceParams> {
  final UserRepository repository;

  RemoveOtherExperienceUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(RemoveOtherExperienceParams params) async {
    return await repository.removeOtherExperience(id: params.id);
  }
}

class RemoveOtherExperienceParams extends Equatable {
  final String id;

  const RemoveOtherExperienceParams(this.id);

  @override
  List<Object> get props => [id];
}
