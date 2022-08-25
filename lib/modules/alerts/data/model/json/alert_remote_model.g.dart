// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertRemoteModel _$AlertRemoteModelFromJson(Map<String, dynamic> json) =>
    AlertRemoteModel(
      id: json['_id'] as String,
      title: json['_title'] as String,
      message: json['_message'] as String,
      isRead: json['_isRead'] as bool,
      sentAt: DateTime.parse(json['_sentAt'] as String),
    );

Map<String, dynamic> _$AlertRemoteModelToJson(AlertRemoteModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      '_title': instance.title,
      '_message': instance.message,
      '_isRead': instance.isRead,
      '_sentAt': instance.sentAt.toIso8601String(),
    };
