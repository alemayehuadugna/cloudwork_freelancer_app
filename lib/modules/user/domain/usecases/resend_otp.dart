import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/user_repository.dart';

class ResendOTPUseCase implements UseCase<void, ResendOTPParams> {
  final UserRepository repository;

  ResendOTPUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(ResendOTPParams params) async {
    return await repository.resendOTP(email: params.email);
  }
}

class ResendOTPParams extends Equatable{
  final String email;

  const ResendOTPParams(this.email);

  @override
  List<Object?> get props => [email];
}
