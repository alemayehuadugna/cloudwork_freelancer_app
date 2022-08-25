// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRemoteModel _$MessageRemoteModelFromJson(Map<String, dynamic> json) =>
    MessageRemoteModel(
      json['_messageId'] as String,
      json['_conversationId'] as String,
      json['_senderId'] as String,
      json['_content'] as String,
      json['_sent'] as bool,
      json['_seen'] as bool,
      DateTime.parse(json['_sentAt'] as String),
      DateTime.parse(json['_updatedAt'] as String),
    );

Map<String, dynamic> _$MessageRemoteModelToJson(MessageRemoteModel instance) =>
    <String, dynamic>{
      '_messageId': instance.id,
      '_conversationId': instance.conversationId,
      '_senderId': instance.senderId,
      '_content': instance.content,
      '_sent': instance.sent,
      '_seen': instance.seen,
      '_sentAt': instance.sentAt.toIso8601String(),
      '_updatedAt': instance.updatedAt.toIso8601String(),
    };
