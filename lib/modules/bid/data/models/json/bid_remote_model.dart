import 'package:json_annotation/json_annotation.dart';

part 'bid_remote_model.g.dart';

@JsonSerializable()
class BidListRemoteModel {
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
  @JsonKey(name: 'expiry')
  late String? expiry;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'progress')
  final String? progress;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  BidListRemoteModel(
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
  );

  factory BidListRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$BidListRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$BidListRemoteModelToJson(this);
  }
}

@JsonSerializable()
class ClientRemoteModel {
  final String clientId;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final int completedJobs;
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
class BidRemoteModel {
  final String freelancerId;
  final double budget;
  final int hours;
  final String coverLetter;
  final bool isTermsAndConditionAgreed;
  final DateTime createdAt;
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
  final String firstName;
  final String lastName;
  final String profilePicture;
  final int numberOfReviews;

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
