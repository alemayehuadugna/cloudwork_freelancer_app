import 'package:CloudWork_Freelancer/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:CloudWork_Freelancer/_core/error/failures.dart';

import '../../../../_core/usecase.dart';
import 'package:equatable/equatable.dart';

class ChangeAvailabilityUseCase implements UseCase<void, ChangeAvailabilityParams> {
  final UserRepository repository;

  ChangeAvailabilityUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(ChangeAvailabilityParams params) async {
    return await repository.changeAvailability(params.available);
  }
}

class ChangeAvailabilityParams extends Equatable {
  final String available;

  const ChangeAvailabilityParams(this.available);

  @override
  List<Object> get props => [available];
}
