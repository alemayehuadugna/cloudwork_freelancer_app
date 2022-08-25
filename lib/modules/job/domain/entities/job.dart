import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final List<ClientEntity>? clientId;
  final String? freelancerId;
  final String title;
  final List<String> skills;
  final double budget;
  final String category;
  final int proposals;
  final int duration;
  late String? expiry;
  final String? language;
  final String? progress;
  final DateTime? createdAt;
  final List<BidEntity> bid;

  JobEntity({
    required this.id,
    required this.clientId,
    required this.freelancerId,
    required this.title,
    required this.skills,
    required this.budget,
    required this.category,
    required this.proposals,
    required this.duration,
    required this.expiry,
    required this.language,
    required this.progress,
    required this.createdAt,
    required this.bid,
  });

  @override
  List<Object?> get props => [
        id,
        clientId,
        freelancerId,
        title,
        skills,
        budget,
        category,
        proposals,
        duration,
        expiry,
        language,
        progress,
        createdAt,
        bid
      ];
}


class ClientEntity extends Equatable {
  final String clientId;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final int completedJobs;
  final DateTime createdAt;

  const ClientEntity(this.clientId, this.firstName, this.lastName,
      this.profilePicture, this.completedJobs, this.createdAt);

  @override
  List<Object?> get props =>
      [clientId, firstName, lastName, profilePicture, completedJobs, createdAt];
}

class JobDetailEntity extends Equatable {
  final String id;
  final List<ClientEntity>? clientId;
  final String? freelancerId;
  final String title;
  final List<String> skills;
  final double budget;
  final int? duration;
  final int proposals;
  late String? expiry;
  final String category;
  final String? language;
  final String progress;
  final DateTime? startDate;
  final List<String>? links;
  final String description;
  final List<dynamic> files;
  final DateTime createdAt;
  final List<BidEntity> bid;

  JobDetailEntity({
    required this.id,
    required this.clientId,
    required this.freelancerId,
    required this.title,
    required this.skills,
    required this.budget,
    required this.duration,
    required this.proposals,
    required this.expiry,
    required this.category,
    required this.language,
    required this.progress,
    required this.startDate,
    required this.links,
    required this.description,
    required this.files,
    required this.createdAt,
    required this.bid,
  });

  @override
  List<Object?> get props => [
        id,
        clientId,
        freelancerId,
        title,
        skills,
        budget,
        duration,
        proposals,
        expiry,
        category,
        language,
        progress,
        startDate,
        links,
        description,
        files,
        createdAt,
        bid
      ];
}

class BidEntity extends Equatable {
  final String? freelancerId;
  final double? budget;
  final int? hours;
  final String? coverLetter;
  final bool? isTermsAndConditionAgreed;
  final DateTime? createdAt;
  ProposalFreelancerEntity freelancer;

  BidEntity(this.freelancerId, this.budget, this.hours, this.coverLetter,
      this.isTermsAndConditionAgreed, this.createdAt, this.freelancer);

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

class ProposalFreelancerEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final int? numberOfReviews;

  const ProposalFreelancerEntity(
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.numberOfReviews,
  );

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        profilePicture,
        numberOfReviews,
      ];
}
