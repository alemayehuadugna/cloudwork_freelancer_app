import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/conversation.dart';
import '../repo/chat_repository.dart';

class ListConversationUseCase
    implements UseCase<Stream<List<Conversation>>, NoParams> {
  final ChatRepository repository;

  ListConversationUseCase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<Conversation>>>> call(
      NoParams params) async {
    try {
      return Right(repository.conversations);
    } catch (e) {
      return Left(ServerFailure("message"));
    }
  }
}
