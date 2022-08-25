import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:CloudWork_Freelancer/modules/user/domain/entities/detail_user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/usecase.dart';
import '../../repo/user_repository.dart';

class SaveOtherExperienceUseCase
    implements UseCase<OtherExperience, SaveOtherExperienceParams> {
  final UserRepository repository;

  SaveOtherExperienceUseCase({required this.repository});

  @override
  Future<Either<Failure, OtherExperience>> call(
      SaveOtherExperienceParams params) async {
    return await repository.saveOtherExperience(
        otherExperience: params.otherExperience);
  }
}

class SaveOtherExperienceParams extends Equatable {
  final OtherExperience otherExperience;

  const SaveOtherExperienceParams(this.otherExperience);

  @override
  List<Object> get props => [otherExperience];
}
