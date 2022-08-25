import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/chat_repository.dart';

class StartConversationUseCase
    implements UseCase<void, StartConversationParams> {
  final ChatRepository repository;

  StartConversationUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(StartConversationParams params) async {
    print("params: $params");
    return await repository.startConversation(
        params.userId, params.otherUserId);
  }
}

class StartConversationParams extends Equatable {
  final String userId;
  final String otherUserId;

  const StartConversationParams(this.userId, this.otherUserId);

  @override
  List<Object> get props => [userId, otherUserId];
}
