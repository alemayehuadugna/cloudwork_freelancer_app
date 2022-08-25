import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/chat_repository.dart';

class StartChatUseCase implements UseCase<void, StartChatParams> {
  final ChatRepository repository;

  StartChatUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(StartChatParams params) async {
    return await repository.initChat(params.userId);
  }
}

class StartChatParams extends Equatable {
  final String userId;

  const StartChatParams(this.userId);

  @override
  List<Object> get props => [userId];
}
