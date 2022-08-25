import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/message.dart';
import '../repo/chat_repository.dart';

class ListMessageUseCase
    implements UseCase<Stream<Map<String, List<Message>>>, NoParams> {
  final ChatRepository repository;

  ListMessageUseCase({required this.repository});

  @override
  Future<Either<Failure, Stream<Map<String, List<Message>>>>> call(
      NoParams params) async {
    try {
      return Right(repository.messages);
    } catch (e) {
      return Left(ServerFailure("message"));
    }
  }
}
