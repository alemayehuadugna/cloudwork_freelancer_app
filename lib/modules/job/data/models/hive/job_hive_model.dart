import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'job_hive_model.g.dart';

@HiveType(typeId: 4)
class ProposalFreelancerHiveModel extends Equatable {
  @HiveField(0)
  final String firstName;

  @HiveField(1)
  final String lastName;

  @HiveField(2)
  final String profilePicture;

  @HiveField(3)
  final int numberOfReviews;

  const ProposalFreelancerHiveModel(
      this.firstName, this.lastName, this.profilePicture, this.numberOfReviews);

  @override
  List<Object?> get props =>
      [firstName, lastName, profilePicture, numberOfReviews];
}

@HiveType(typeId: 3)
class BidHiveModel extends Equatable {
  @HiveField(0)
  final String freelancerId;

  @HiveField(1)
  final double budget;

  @HiveField(2)
  final int hours;

  @HiveField(3)
  final String coverLetter;

  @HiveField(4)
  final bool isTermsAndConditionAgreed;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  ProposalFreelancerHiveModel freelancer;

  BidHiveModel(
    this.freelancerId,
    this.budget,
    this.hours,
    this.coverLetter,
    this.isTermsAndConditionAgreed,
    this.createdAt,
    this.freelancer,
  );

  @override
  List<Object?> get props => [
        freelancerId,
        budget,
        hours,
        coverLetter,
        isTermsAndConditionAgreed,
        createdAt,
        freelancer
      ];
}

@HiveType(typeId: 2)
class ClientHiveModel extends Equatable {
  @HiveField(0)
  final String clientId;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String profilePicture;

  @HiveField(4)
  final int completedJobs;

  @HiveField(5)
  final DateTime createdAt;

  const ClientHiveModel(this.clientId, this.firstName, this.lastName,
      this.profilePicture, this.completedJobs, this.createdAt);

  @override
  List<Object?> get props =>
      [clientId, firstName, lastName, profilePicture, completedJobs, createdAt];
}

@HiveType(typeId: 1)
class JobHiveModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<ClientHiveModel>? clientId;

  @HiveField(2)
  final String? freelancerId;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final List<String> skills;

  @HiveField(5)
  final double budget;

  @HiveField(6)
  final int proposals;

  @HiveField(7)
  final int duration;

  @HiveField(8)
  final String? expiry;

  @HiveField(9)
  final String category;

  @HiveField(10)
  final String? language;

  @HiveField(11)
  final String progress;

  @HiveField(12)
  final DateTime createdAt;

  @HiveField(13)
  final List<BidHiveModel> bid;

  const JobHiveModel(
      this.id,
      this.clientId,
      this.freelancerId,
      this.title,
      this.skills,
      this.budget,
      this.proposals,
      this.duration,
      this.expiry,
      this.category,
      this.language,
      this.progress,
      this.createdAt, 
      this.bid, 
      );

  @override
  List<Object?> get props => [
        id,
        clientId,
        freelancerId,
        title,
        skills,
        budget,
        proposals,
        duration,
        expiry,
        category,
        language,
        progress,
        createdAt, 
        bid
      ];
}
