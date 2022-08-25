import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String? id;
  final String conversationId;
  final String senderId;
  final String content;
  final bool sent;
  final bool seen;
  final DateTime sentAt;
  final DateTime updatedAt;

  const Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.sent,
    required this.seen,
    required this.sentAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        conversationId,
        senderId,
        content,
        sent,
        seen,
        sentAt,
        updatedAt,
      ];
}
