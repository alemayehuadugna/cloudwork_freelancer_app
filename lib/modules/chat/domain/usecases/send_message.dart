import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/chat_repository.dart';

class SendMessageUseCase implements UseCase<void, SendMessageParams> {
  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    return await repository.sendMessage(params.conversationId, params.content);
  }
}

class SendMessageParams extends Equatable {
  final String conversationId;
  final String content;

  const SendMessageParams(
    this.conversationId,
    this.content,
  );

  @override
  List<Object> get props => [
        conversationId,
        content,
      ];
}
