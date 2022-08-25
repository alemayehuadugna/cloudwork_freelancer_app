// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_page_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultPageRemoteModel _$ResultPageRemoteModelFromJson(
        Map<String, dynamic> json) =>
    ResultPageRemoteModel(
      current: json['current'] as int,
      pageSize: json['pageSize'] as int,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      first: json['first'] as bool,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$ResultPageRemoteModelToJson(
        ResultPageRemoteModel instance) =>
    <String, dynamic>{
      'current': instance.current,
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'last': instance.last,
    };
