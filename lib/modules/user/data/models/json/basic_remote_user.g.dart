// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_remote_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicRemoteUser _$BasicRemoteUserFromJson(Map<String, dynamic> json) =>
    BasicRemoteUser(
      json['id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['userName'] as String,
      json['completedJobs'] as int,
      json['ongoingJobs'] as int,
      json['cancelledJobs'] as int,
      json['numberOfReviews'] as int,
      json['profilePicture'] as String,
      (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      json['isEmailVerified'] as bool,
      json['isProfileComplete'] as bool,
    );

Map<String, dynamic> _$BasicRemoteUserToJson(BasicRemoteUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'userName': instance.userName,
      'profilePicture': instance.profilePicture,
      'roles': instance.roles,
      'isEmailVerified': instance.isEmailVerified,
      'isProfileComplete': instance.isProfileComplete,
      'completedJobs': instance.completedJobs,
      'ongoingJobs': instance.ongoingJobs,
      'cancelledJobs': instance.cancelledJobs,
      'numberOfReviews': instance.numberOfReviews,
    };
