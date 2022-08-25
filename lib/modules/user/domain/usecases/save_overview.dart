import 'package:CloudWork_Freelancer/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/usecase.dart';

class SaveOverviewUseCase implements UseCase<void, SaveOverviewParams> {
  final UserRepository repository;

  SaveOverviewUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(SaveOverviewParams params) async {
    return await repository.saveOverview(overview: params.overview);
  }
}

class SaveOverviewParams extends Equatable {
  final String overview;

  const SaveOverviewParams(this.overview);

  @override
  List<Object> get props => [overview];
}
