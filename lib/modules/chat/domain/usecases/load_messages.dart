import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/chat_repository.dart';

class LoadMessagesUseCase implements UseCase<void, LoadMessagesParams> {
  final ChatRepository repository;

  LoadMessagesUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(LoadMessagesParams params) async {
    return await repository.loadMessages(
        params.conversationId, params.pagination, params.filter);
  }
}

class LoadMessagesParams extends Equatable {
  final String conversationId;
  final dynamic pagination;
  final dynamic filter;

  const LoadMessagesParams(
    this.conversationId,
    this.pagination,
    this.filter,
  );

  @override
  List<Object> get props => [
        conversationId,
        pagination,
        filter,
      ];
}
