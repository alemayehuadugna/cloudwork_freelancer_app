import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../entities/conversation.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> initChat(String userId);

  Future<Either<Failure, void>> startConversation(String fid, String cid);
  Future<Either<Failure, void>> sendMessage(
      String conversationId, dynamic content);
  Future<Either<Failure, void>> loadMessages(
      String conversationId, dynamic pagination, dynamic filter);
  Stream<List<Conversation>> get conversations;
  Stream<Map<String, List<Message>>> get messages;
  Future<Either<Failure, void>> dispose();
}
