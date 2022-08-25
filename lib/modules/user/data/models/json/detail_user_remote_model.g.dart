// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_user_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainServiceRemoteModel _$MainServiceRemoteModelFromJson(
        Map<String, dynamic> json) =>
    MainServiceRemoteModel(
      json['category'] as String,
      json['subCategory'] as String,
    );

Map<String, dynamic> _$MainServiceRemoteModelToJson(
        MainServiceRemoteModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'subCategory': instance.subcategory,
    };

AddressRemoteModel _$AddressRemoteModelFromJson(Map<String, dynamic> json) =>
    AddressRemoteModel(
      json['region'] as String,
      json['city'] as String,
      json['areaName'] as String?,
      json['postalCode'] as String?,
    );

Map<String, dynamic> _$AddressRemoteModelToJson(AddressRemoteModel instance) =>
    <String, dynamic>{
      'region': instance.region,
      'city': instance.city,
      'areaName': instance.areaName,
      'postalCode': instance.postalCode,
    };

RangeDateRemoteModel _$RangeDateRemoteModelFromJson(
        Map<String, dynamic> json) =>
    RangeDateRemoteModel(
      DateTime.parse(json['start'] as String),
      DateTime.parse(json['end'] as String),
    );

Map<String, dynamic> _$RangeDateRemoteModelToJson(
        RangeDateRemoteModel instance) =>
    <String, dynamic>{
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };

RatingRemoteModel _$RatingRemoteModelFromJson(Map<String, dynamic> json) =>
    RatingRemoteModel(
      (json['rate'] as num).toDouble(),
      (json['totalRate'] as num).toDouble(),
      (json['totalRaters'] as num).toDouble(),
    );

Map<String, dynamic> _$RatingRemoteModelToJson(RatingRemoteModel instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'totalRate': instance.totalRate,
      'totalRaters': instance.totalRaters,
    };

SocialLinkRemoteModel _$SocialLinkRemoteModelFromJson(
        Map<String, dynamic> json) =>
    SocialLinkRemoteModel(
      json['socialMedia'] as String,
      json['link'] as String,
    );

Map<String, dynamic> _$SocialLinkRemoteModelToJson(
        SocialLinkRemoteModel instance) =>
    <String, dynamic>{
      'socialMedia': instance.socialMedia,
      'link': instance.link,
    };

LanguageRemoteModel _$LanguageRemoteModelFromJson(Map<String, dynamic> json) =>
    LanguageRemoteModel(
      json['language'] as String,
      json['proficiencyLevel'] as String,
    );

Map<String, dynamic> _$LanguageRemoteModelToJson(
        LanguageRemoteModel instance) =>
    <String, dynamic>{
      'language': instance.language,
      'proficiencyLevel': instance.proficiencyLevel,
    };

EducationRemoteModel _$EducationRemoteModelFromJson(
        Map<String, dynamic> json) =>
    EducationRemoteModel(
      json['institution'] as String,
      RangeDateRemoteModel.fromJson(
          json['dateAttended'] as Map<String, dynamic>),
      json['degree'] as String,
      json['areaOfStudy'] as String,
      json['description'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$EducationRemoteModelToJson(
    EducationRemoteModel instance) {
  final val = <String, dynamic>{
    'institution': instance.institution,
    'dateAttended': instance.dateAttended,
    'degree': instance.degree,
    'areaOfStudy': instance.areaOfStudy,
    'description': instance.description,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', EducationRemoteModel.toNull(instance.id));
  return val;
}

EmploymentRemoteModel _$EmploymentRemoteModelFromJson(
        Map<String, dynamic> json) =>
    EmploymentRemoteModel(
      json['company'] as String,
      json['city'] as String,
      json['region'] as String,
      json['title'] as String,
      RangeDateRemoteModel.fromJson(json['period'] as Map<String, dynamic>),
      json['summary'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$EmploymentRemoteModelToJson(
    EmploymentRemoteModel instance) {
  final val = <String, dynamic>{
    'company': instance.company,
    'city': instance.city,
    'region': instance.region,
    'title': instance.title,
    'period': instance.period,
    'summary': instance.summary,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', EmploymentRemoteModel.toNull(instance.id));
  return val;
}

OtherExperienceRemoteModel _$OtherExperienceRemoteModelFromJson(
        Map<String, dynamic> json) =>
    OtherExperienceRemoteModel(
      json['subject'] as String,
      json['description'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$OtherExperienceRemoteModelToJson(
    OtherExperienceRemoteModel instance) {
  final val = <String, dynamic>{
    'subject': instance.subject,
    'description': instance.description,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', OtherExperienceRemoteModel.toNull(instance.id));
  return val;
}

JobOfferRemoteModel _$JobOfferRemoteModelFromJson(Map<String, dynamic> json) =>
    JobOfferRemoteModel(
      json['clientId'] as String,
      json['jobId'] as String,
      json['message'] as String,
    );

Map<String, dynamic> _$JobOfferRemoteModelToJson(
        JobOfferRemoteModel instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'jobId': instance.jobId,
      'message': instance.message,
    };

DetailUserRemoteModel _$DetailUserRemoteModelFromJson(
        Map<String, dynamic> json) =>
    DetailUserRemoteModel(
      json['id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['gender'] as String?,
      (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      json['overview'] as String,
      json['completedJobs'] as int,
      json['ongoingJobs'] as int,
      json['cancelledJobs'] as int,
      json['numberOfReviews'] as int,
      json['expertise'] as String,
      json['verified'] as bool,
      DateTime.parse(json['joinedDate'] as String),
      json['profilePicture'] as String,
      json['userName'] as String,
      (json['earning'] as num).toDouble(),
      RatingRemoteModel.fromJson(json['skillRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['qualityOfWorkRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['availabilityRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['adherenceToScheduleRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['communicationRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['cooperationRating'] as Map<String, dynamic>),
      (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      json['isEmailVerified'] as bool,
      json['isPhoneVerified'] as bool,
      json['isProfileComplete'] as bool,
      (json['profileCompletedPercentage'] as num).toDouble(),
      json['available'] as String,
      json['mainService'] == null
          ? null
          : MainServiceRemoteModel.fromJson(
              json['mainService'] as Map<String, dynamic>),
      json['address'] == null
          ? null
          : AddressRemoteModel.fromJson(
              json['address'] as Map<String, dynamic>),
      (json['socialLinks'] as List<dynamic>?)
          ?.map(
              (e) => SocialLinkRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['languages'] as List<dynamic>?)
          ?.map((e) => LanguageRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['educations'] as List<dynamic>?)
          ?.map((e) => EducationRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['employments'] as List<dynamic>?)
          ?.map(
              (e) => EmploymentRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['otherExperiences'] as List<dynamic>?)
          ?.map((e) =>
              OtherExperienceRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DetailUserRemoteModelToJson(
        DetailUserRemoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'userName': instance.userName,
      'profilePicture': instance.profilePicture,
      'completedJobs': instance.completedJobs,
      'ongoingJobs': instance.ongoingJobs,
      'cancelledJobs': instance.cancelledJobs,
      'numberOfReviews': instance.numberOfReviews,
      'joinedDate': instance.joinedDate.toIso8601String(),
      'roles': instance.roles,
      'earning': instance.earning,
      'skillRating': instance.skillRating,
      'qualityOfWorkRating': instance.qualityOfWorkRating,
      'availabilityRating': instance.availabilityRating,
      'adherenceToScheduleRating': instance.adherenceToScheduleRating,
      'communicationRating': instance.communicationRating,
      'cooperationRating': instance.cooperationRating,
      'isEmailVerified': instance.isEmailVerified,
      'isPhoneVerified': instance.isPhoneVerified,
      'isProfileComplete': instance.isProfileComplete,
      'profileCompletedPercentage': instance.profileCompletedPercentage,
      'gender': instance.gender,
      'skills': instance.skills,
      'overview': instance.overview,
      'expertise': instance.expertise,
      'verified': instance.verified,
      'available': instance.available,
      'mainService': instance.mainService,
      'address': instance.address,
      'socialLinks': instance.socialLinks,
      'languages': instance.languages,
      'educations': instance.educations,
      'employments': instance.employments,
      'otherExperiences': instance.otherExperiences,
    };
