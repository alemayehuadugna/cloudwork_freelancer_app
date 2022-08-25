import 'package:json_annotation/json_annotation.dart';

part 'conversation_remote_model.g.dart';

@JsonSerializable()
class ConversationUserRemoteModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'profilePicture')
  final String profilePicture;

  ConversationUserRemoteModel(
      this.id, this.firstName, this.lastName, this.profilePicture);

  factory ConversationUserRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationUserRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationUserRemoteModelToJson(this);
}

@JsonSerializable()
class MemberRemoteModel {
  final String userType;
  final String userId;
  final ConversationUserRemoteModel? user;

  MemberRemoteModel(this.userType, this.userId, this.user);

  factory MemberRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$MemberRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberRemoteModelToJson(this);
}

@JsonSerializable()
class ConversationRemoteModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: '_members')
  final List<MemberRemoteModel> members;

  @JsonKey(name: '_lastMessage')
  final dynamic lastMessage;

  ConversationRemoteModel(this.id, this.members, this.lastMessage);

  factory ConversationRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationRemoteModelToJson(this);
}
