import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/user_repository.dart';

class UploadProfilePictureUseCase
    implements UseCase<String, UploadProfilePictureParams> {
  final UserRepository repository;

  UploadProfilePictureUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
      UploadProfilePictureParams params) async {
    return await repository.uploadProfilePicture(file: params.file);
  }
}

class UploadProfilePictureParams extends Equatable {
  final file;

  const UploadProfilePictureParams(this.file);

  @override
  List<Object> get props => [file];
}
