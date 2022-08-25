import 'package:dartz/dartz.dart';
import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/usecase.dart';
import '../../entities/detail_user.dart';
import '../../repo/user_repository.dart';

class SaveEducationUseCase implements UseCase<Education, SaveEducationParams> {
  final UserRepository repository;

  SaveEducationUseCase({required this.repository});

  @override
  Future<Either<Failure, Education>> call(SaveEducationParams params) async {
    return await repository.saveEducation(education: params.education);
  }
}

class SaveEducationParams extends Equatable {
  final Education education;

  const SaveEducationParams(this.education);

  @override
  List<Object> get props => [education];
}
