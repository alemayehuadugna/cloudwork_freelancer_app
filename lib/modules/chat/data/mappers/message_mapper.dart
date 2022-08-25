import '../../domain/entities/message.dart';
import '../models/json/message_remote_model.dart';

class MessageMapper {
  static List<Message> fromJson(dynamic json) {
    List<Message> messages = [];
    json.forEach((e) {
      final temp = MessageRemoteModel.fromJson(e);
      messages.add(Message(
          id: temp.id,
          conversationId: temp.conversationId,
          senderId: temp.senderId,
          content: temp.content,
          sent: temp.sent,
          seen: temp.seen,
          sentAt: temp.sentAt,
          updatedAt: temp.updatedAt));
    });

    return messages;
  }
}
