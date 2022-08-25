import 'package:CloudWork_Freelancer/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/usecase.dart';

class ChangePasswordUseCase implements UseCase<void, ChangePasswordParams> {
  final UserRepository repository;

  ChangePasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return await repository.changePassword(
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
    );
  }
}

class ChangePasswordParams extends Equatable {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordParams(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];
}
