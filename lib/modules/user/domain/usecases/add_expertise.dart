import 'package:dartz/dartz.dart';

import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/usecase.dart';
import '../repo/user_repository.dart';

class AddExpertiseUseCase implements UseCase<void, AddExpertiseParams> {
  final UserRepository repository;

  AddExpertiseUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(AddExpertiseParams params) async {
    return await repository.addExpertise(expertise: params.expertise);
  }
}

class AddExpertiseParams extends Equatable {
  final String expertise;

  const AddExpertiseParams(this.expertise);

  @override
  List<Object?> get props => [expertise];
}
