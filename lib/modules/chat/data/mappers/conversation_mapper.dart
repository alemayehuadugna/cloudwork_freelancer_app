import 'package:CloudWork_Freelancer/modules/chat/data/models/json/message_remote_model.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../models/json/conversation_remote_model.dart';

class ConversationMapper {
  static List<Conversation> fromJson(dynamic json) {
    List<Conversation> conversations = [];
    json.forEach((e) {
      final temp = ConversationRemoteModel.fromJson(e);
      var tempLastMessage;
      if (temp.lastMessage != null) {
        var remoteTemp = MessageRemoteModel.fromJson(temp.lastMessage);
        tempLastMessage = Message(
            id: remoteTemp.id,
            conversationId: remoteTemp.conversationId,
            senderId: remoteTemp.senderId,
            content: remoteTemp.content,
            sent: remoteTemp.sent,
            seen: remoteTemp.seen,
            sentAt: remoteTemp.sentAt,
            updatedAt: remoteTemp.updatedAt);
      }

      conversations.add(Conversation(tempLastMessage,
          id: temp.id,
          members: temp.members
              .map(
                (e) => Member(
                    e.user != null
                        ? ConversationUser(e.user!.id, e.user!.firstName,
                            e.user!.lastName, e.user!.profilePicture)
                        : null,
                    userId: e.userId,
                    userType: e.userType),
              )
              .toList()));
    });
    return conversations;
  }
}
