import 'package:json_annotation/json_annotation.dart';

part 'job_remote_model.g.dart';

@JsonSerializable()
class JobRemoteModel {
  @JsonKey(name: 'jobId')
  final String id;
  @JsonKey(name: 'clientId')
  final List<ClientRemoteModel>? clientId;
  @JsonKey(name: 'freelancerId')
  final String? freelancerId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'skills')
  final List<String> skills;
  @JsonKey(name: 'budget')
  final double budget;
  @JsonKey(name: 'category')
  final String category;
  @JsonKey(name: 'proposals')
  final int proposals;
  @JsonKey(name: 'duration')
  final int duration;
  @JsonKey(name: '5,expiry:')
  late String? expiry;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'progress')
  final String? progress;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'bid')
  final List<BidRemoteModel> bid;

  JobRemoteModel(
    this.id,
    this.clientId,
    this.freelancerId,
    this.title,
    this.skills,
    this.budget,
    this.category,
    this.proposals,
    this.duration,
    this.expiry,
    this.language,
    this.progress,
    this.createdAt,
    this.bid
  );

  factory JobRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$JobRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$JobRemoteModelToJson(this);
  }
}

@JsonSerializable()
class ClientRemoteModel {
  @JsonKey(name: 'clientId')
  final String clientId;
  @JsonKey(name: 'firstName')
  final String firstName;
  @JsonKey(name: 'lastName')
  final String lastName;
  @JsonKey(name: 'profilePicture')
  final String profilePicture;
  @JsonKey(name: 'completedJobs')
  final int completedJobs;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  const ClientRemoteModel(this.clientId, this.firstName, this.lastName,
      this.profilePicture, this.completedJobs, this.createdAt);

  factory ClientRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$ClientRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$ClientRemoteModelToJson(this);
  }
}

@JsonSerializable()
class JobDetailRemoteModel {
  @JsonKey(name: 'jobId')
  final String id;
  @JsonKey(name: 'clientId')
  final List<ClientRemoteModel>? clientId;
  @JsonKey(name: 'freelancerId')
  final String? freelancerId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'skills')
  final List<String> skills;
  @JsonKey(name: 'budget')
  final double budget;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'proposals')
  final int proposals;
  @JsonKey(name: 'expiry')
  late String? expiry;
  @JsonKey(name: 'category')
  final String category;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'progress')
  final String progress;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'links')
  final List<String>? links;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'files')
  final List<dynamic> files;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'bid')
  final List<BidRemoteModel> bid;

  JobDetailRemoteModel(
    this.id,
    this.clientId,
    this.freelancerId,
    this.title,
    this.skills,
    this.budget,
    this.duration,
    this.proposals,
    this.expiry,
    this.category,
    this.language,
    this.progress,
    this.startDate,
    this.links,
    this.description,
    this.files,
    this.createdAt,
    this.bid,
  );

  factory JobDetailRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$JobDetailRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$JobDetailRemoteModelToJson(this);
  }
}

@JsonSerializable()
class BidRemoteModel {
  @JsonKey(name: 'freelancerId')
  final String? freelancerId;
  @JsonKey(name: 'budget')
  final double? budget;
  @JsonKey(name: 'hours')
  final int? hours;
  @JsonKey(name: 'coverLetter')
  final String? coverLetter;
  @JsonKey(name: 'isTermsAndConditionAgreed')
  final bool? isTermsAndConditionAgreed;
  @JsonKey(name: 'createdAt:')
  final DateTime? createdAt;
  @JsonKey(name: 'freelancer')
  ProposalFreelancerRemoteModel freelancer;

  BidRemoteModel(
    this.freelancerId,
    this.budget,
    this.hours,
    this.coverLetter,
    this.isTermsAndConditionAgreed,
    this.createdAt,
    this.freelancer,
  );

  factory BidRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$BidRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$BidRemoteModelToJson(this);
  }
}

@JsonSerializable()
class ProposalFreelancerRemoteModel {
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'profilePicture')
  final String? profilePicture;
  @JsonKey(name: 'numberOfReviews')
  final int? numberOfReviews;

  const ProposalFreelancerRemoteModel(
      this.firstName, this.lastName, this.profilePicture, this.numberOfReviews);

  factory ProposalFreelancerRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$ProposalFreelancerRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$ProposalFreelancerRemoteModelToJson(this);
  }
}

@JsonSerializable()
class FilterRemoteModel {
  final String progress;

  const FilterRemoteModel(this.progress);

  Map<String, dynamic> toJson() {
    return _$FilterRemoteModelToJson(this);
  }
}
