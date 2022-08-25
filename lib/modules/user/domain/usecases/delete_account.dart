import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/user_repository.dart';

class DeleteAccountUseCase implements UseCase<void, DeleteAccountParams> {
  final UserRepository repository;

  DeleteAccountUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(DeleteAccountParams params) async {
    return await repository.deleteAccount(
      reason: params.reason,
      password: params.password,
    );
  }
}

class DeleteAccountParams extends Equatable {
  final String reason;
  final String password;

  const DeleteAccountParams(this.reason, this.password);

  @override
  List<Object> get props => [reason, password];
}
