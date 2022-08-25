// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_remote_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUser _$CreateUserFromJson(Map<String, dynamic> json) => CreateUser(
      json['firstName'] as String,
      json['lastName'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['password'] as String,
      json['isPolicyAgreed'] as bool,
    );

Map<String, dynamic> _$CreateUserToJson(CreateUser instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'isPolicyAgreed': instance.isPolicyAgreed,
    };
