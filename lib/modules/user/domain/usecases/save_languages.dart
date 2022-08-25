import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:CloudWork_Freelancer/modules/user/domain/entities/detail_user.dart';
import 'package:CloudWork_Freelancer/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/usecase.dart';

class SaveLanguagesUseCase implements UseCase<void, SaveLanguagesParams> {
  final UserRepository repository;

  SaveLanguagesUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(SaveLanguagesParams params) async {
    return await repository.saveLanguages(languages: params.languages);
  }
}

class SaveLanguagesParams extends Equatable {
  final List<Language> languages;

  const SaveLanguagesParams(this.languages);

  @override
  List<Object> get props => [languages];
}
