import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/user_repository.dart';

class SignInUseCase implements UseCase<String, Params> {
  final UserRepository repository;

  SignInUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.authenticate(
      phone: params.phone,
      password: params.password,
    );
  }
}

class Params extends Equatable {
  final String phone;
  final String password;

  const Params({required this.phone, required this.password});

  @override
  List<Object?> get props => [phone, password];
}
