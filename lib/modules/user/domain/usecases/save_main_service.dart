import 'package:CloudWork_Freelancer/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/usecase.dart';

class SaveMainServiceUseCase implements UseCase<void, SaveMainServiceParams> {
  final UserRepository repository;

  SaveMainServiceUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(SaveMainServiceParams params) async {
    return await repository.saveMainService(
      category: params.category,
      subcategory: params.subcategory,
    );
  }
}

class SaveMainServiceParams extends Equatable {
  final String category;
  final String subcategory;

  const SaveMainServiceParams(this.category, this.subcategory);

  @override
  List<Object> get props => [category, subcategory];
}
