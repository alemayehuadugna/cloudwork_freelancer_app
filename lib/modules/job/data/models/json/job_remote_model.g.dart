// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobRemoteModel _$JobRemoteModelFromJson(Map<String, dynamic> json) =>
    JobRemoteModel(
      json['jobId'] as String,
      (json['clientId'] as List<dynamic>?)
          ?.map((e) => ClientRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['freelancerId'] as String?,
      json['title'] as String,
      (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      (json['budget'] as num).toDouble(),
      json['category'] as String,
      json['proposals'] as int,
      json['duration'] as int,
      json['5,expiry:'] as String?,
      json['language'] as String?,
      json['progress'] as String?,
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      (json['bid'] as List<dynamic>)
          .map((e) => BidRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobRemoteModelToJson(JobRemoteModel instance) =>
    <String, dynamic>{
      'jobId': instance.id,
      'clientId': instance.clientId,
      'freelancerId': instance.freelancerId,
      'title': instance.title,
      'skills': instance.skills,
      'budget': instance.budget,
      'category': instance.category,
      'proposals': instance.proposals,
      'duration': instance.duration,
      '5,expiry:': instance.expiry,
      'language': instance.language,
      'progress': instance.progress,
      'createdAt': instance.createdAt?.toIso8601String(),
      'bid': instance.bid,
    };

ClientRemoteModel _$ClientRemoteModelFromJson(Map<String, dynamic> json) =>
    ClientRemoteModel(
      json['clientId'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['profilePicture'] as String,
      json['completedJobs'] as int,
      DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ClientRemoteModelToJson(ClientRemoteModel instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePicture': instance.profilePicture,
      'completedJobs': instance.completedJobs,
      'createdAt': instance.createdAt.toIso8601String(),
    };

JobDetailRemoteModel _$JobDetailRemoteModelFromJson(
        Map<String, dynamic> json) =>
    JobDetailRemoteModel(
      json['jobId'] as String,
      (json['clientId'] as List<dynamic>?)
          ?.map((e) => ClientRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['freelancerId'] as String?,
      json['title'] as String,
      (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      (json['budget'] as num).toDouble(),
      json['duration'] as int?,
      json['proposals'] as int,
      json['expiry'] as String?,
      json['category'] as String,
      json['language'] as String?,
      json['progress'] as String,
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      (json['links'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['description'] as String,
      json['files'] as List<dynamic>,
      DateTime.parse(json['createdAt'] as String),
      (json['bid'] as List<dynamic>)
          .map((e) => BidRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobDetailRemoteModelToJson(
        JobDetailRemoteModel instance) =>
    <String, dynamic>{
      'jobId': instance.id,
      'clientId': instance.clientId,
      'freelancerId': instance.freelancerId,
      'title': instance.title,
      'skills': instance.skills,
      'budget': instance.budget,
      'duration': instance.duration,
      'proposals': instance.proposals,
      'expiry': instance.expiry,
      'category': instance.category,
      'language': instance.language,
      'progress': instance.progress,
      'startDate': instance.startDate?.toIso8601String(),
      'links': instance.links,
      'description': instance.description,
      'files': instance.files,
      'createdAt': instance.createdAt.toIso8601String(),
      'bid': instance.bid,
    };

BidRemoteModel _$BidRemoteModelFromJson(Map<String, dynamic> json) =>
    BidRemoteModel(
      json['freelancerId'] as String?,
      (json['budget'] as num?)?.toDouble(),
      json['hours'] as int?,
      json['coverLetter'] as String?,
      json['isTermsAndConditionAgreed'] as bool?,
      json['createdAt:'] == null
          ? null
          : DateTime.parse(json['createdAt:'] as String),
      ProposalFreelancerRemoteModel.fromJson(
          json['freelancer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BidRemoteModelToJson(BidRemoteModel instance) =>
    <String, dynamic>{
      'freelancerId': instance.freelancerId,
      'budget': instance.budget,
      'hours': instance.hours,
      'coverLetter': instance.coverLetter,
      'isTermsAndConditionAgreed': instance.isTermsAndConditionAgreed,
      'createdAt:': instance.createdAt?.toIso8601String(),
      'freelancer': instance.freelancer,
    };

ProposalFreelancerRemoteModel _$ProposalFreelancerRemoteModelFromJson(
        Map<String, dynamic> json) =>
    ProposalFreelancerRemoteModel(
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['profilePicture'] as String?,
      json['numberOfReviews'] as int?,
    );

Map<String, dynamic> _$ProposalFreelancerRemoteModelToJson(
        ProposalFreelancerRemoteModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePicture': instance.profilePicture,
      'numberOfReviews': instance.numberOfReviews,
    };

FilterRemoteModel _$FilterRemoteModelFromJson(Map<String, dynamic> json) =>
    FilterRemoteModel(
      json['progress'] as String,
    );

Map<String, dynamic> _$FilterRemoteModelToJson(FilterRemoteModel instance) =>
    <String, dynamic>{
      'progress': instance.progress,
    };
