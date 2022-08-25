import 'package:dartz/dartz.dart';
import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/usecase.dart';
import '../repo/user_repository.dart';

class SaveSkillsUseCase implements UseCase<void, SaveSkillsParams> {
  final UserRepository repository;

  SaveSkillsUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(SaveSkillsParams params) async {
    return await repository.saveSkills(skills: params.skills);
  }
}

class SaveSkillsParams extends Equatable {
  final List<String> skills;

  const SaveSkillsParams(this.skills);

  @override
  List<Object> get props => [skills];
}
