import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/user_repository.dart';

class RegisterUseCase implements UseCase<String, RegisterParams> {
  final UserRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(RegisterParams params) async {
    return await repository.register(params);
  }
}

class RegisterParams extends Equatable {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final bool hasAgreed;

  const RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.hasAgreed,
  });

  @override
  List<Object?> get props =>
      [lastName, firstName, phone, email, password, hasAgreed];
}
