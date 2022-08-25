import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:CloudWork_Freelancer/_shared/domain/entities/address.dart';
import 'package:CloudWork_Freelancer/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/usecase.dart';

class SaveBasicInfoUseCase implements UseCase<void, SaveBasicInfoParams> {
  final UserRepository repository;

  SaveBasicInfoUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(SaveBasicInfoParams params) async {
    return repository.saveBasicInfo(
      params.address,
      params.available,
      params.gender,
    );
  }
}

class SaveBasicInfoParams extends Equatable {
  final Address address;
  final String available;
  final String gender;

  const SaveBasicInfoParams(this.address, this.available, this.gender);

  @override
  List<Object> get props => [address, available, gender];
}
