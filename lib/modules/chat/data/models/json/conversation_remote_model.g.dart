// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationUserRemoteModel _$ConversationUserRemoteModelFromJson(
        Map<String, dynamic> json) =>
    ConversationUserRemoteModel(
      json['_id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['profilePicture'] as String,
    );

Map<String, dynamic> _$ConversationUserRemoteModelToJson(
        ConversationUserRemoteModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePicture': instance.profilePicture,
    };

MemberRemoteModel _$MemberRemoteModelFromJson(Map<String, dynamic> json) =>
    MemberRemoteModel(
      json['userType'] as String,
      json['userId'] as String,
      json['user'] == null
          ? null
          : ConversationUserRemoteModel.fromJson(
              json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemberRemoteModelToJson(MemberRemoteModel instance) =>
    <String, dynamic>{
      'userType': instance.userType,
      'userId': instance.userId,
      'user': instance.user,
    };

ConversationRemoteModel _$ConversationRemoteModelFromJson(
        Map<String, dynamic> json) =>
    ConversationRemoteModel(
      json['_id'] as String,
      (json['_members'] as List<dynamic>)
          .map((e) => MemberRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['_lastMessage'],
    );

Map<String, dynamic> _$ConversationRemoteModelToJson(
        ConversationRemoteModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      '_members': instance.members,
      '_lastMessage': instance.lastMessage,
    };
