import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecase.dart';
import '../../entities/detail_user.dart';
import '../../repo/user_repository.dart';

class SaveEmploymentUseCase
    implements UseCase<Employment, SaveEmploymentParams> {
  final UserRepository repository;

  SaveEmploymentUseCase({required this.repository});

  @override
  Future<Either<Failure, Employment>> call(SaveEmploymentParams params) async {
    return await repository.saveEmployment(employment: params.employment);
  }
}

class SaveEmploymentParams extends Equatable {
  final Employment employment;

  const SaveEmploymentParams(this.employment);

  @override
  List<Object?> get props => [employment];
}
