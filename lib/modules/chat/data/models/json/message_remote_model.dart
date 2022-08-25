import 'package:json_annotation/json_annotation.dart';

part 'message_remote_model.g.dart';

@JsonSerializable()
class MessageRemoteModel {
  @JsonKey(name: '_messageId')
  final String id;
  @JsonKey(name: '_conversationId')
  final String conversationId;
  @JsonKey(name: '_senderId')
  final String senderId;
  @JsonKey(name: '_content')
  final String content;
  @JsonKey(name: '_sent')
  final bool sent;
  @JsonKey(name: '_seen')
  final bool seen;
  @JsonKey(name: '_sentAt')
  final DateTime sentAt;
  @JsonKey(name: '_updatedAt')
  final DateTime updatedAt;

  MessageRemoteModel(
    this.id,
    this.conversationId,
    this.senderId,
    this.content,
    this.sent,
    this.seen,
    this.sentAt,
    this.updatedAt,
  );

  factory MessageRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$MessageRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageRemoteModelToJson(this);
}
