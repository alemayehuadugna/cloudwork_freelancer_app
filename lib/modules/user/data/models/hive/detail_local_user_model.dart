import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../../_shared/data/models/hive/common_model.dart';


part 'detail_local_user_model.g.dart';

@HiveType(typeId: 6)
class MainServiceLocalModel extends Equatable {
  @HiveField(0)
  final String category;

  @HiveField(1)
  final String subcategory;

  const MainServiceLocalModel(this.category, this.subcategory);

  @override
  List<Object?> get props => [category, subcategory];
}

@HiveType(typeId: 5)
class OtherExperienceModel extends Equatable {
  @HiveField(0)
  final String subject;

  @HiveField(1)
  final String description;
  @HiveField(2)
  final String? id;

  const OtherExperienceModel(this.subject, this.description, {this.id});

  @override
  List<Object?> get props => [subject, description, id];
}

@HiveType(typeId: 4)
class EmploymentModel extends Equatable {
  @HiveField(0)
  final String company;

  @HiveField(1)
  final String city;

  @HiveField(2)
  final String region;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final RangeDateModel period;

  @HiveField(5)
  final String summary;

  @HiveField(6)
  final String? id;

  const EmploymentModel(this.company, this.city, this.region, this.title,
      this.period, this.summary,
      {this.id});

  @override
  List<Object?> get props =>
      [company, city, region, title, period, summary, id];
}

@HiveType(typeId: 3)
class EducationModel extends Equatable {
  @HiveField(0)
  final String institution;

  @HiveField(1)
  final RangeDateModel dateAttended;

  @HiveField(2)
  final String degree;

  @HiveField(3)
  final String areaOfStudy;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String? id;

  const EducationModel(this.institution, this.dateAttended, this.degree,
      this.areaOfStudy, this.description,
      {this.id});

  @override
  List<Object?> get props =>
      [institution, dateAttended, degree, areaOfStudy, description, id];
}

@HiveType(typeId: 2)
class LanguageModel extends Equatable {
  @HiveField(0)
  final String language;

  @HiveField(1)
  final String proficiencyLevel;

  const LanguageModel(this.language, this.proficiencyLevel);

  @override
  List<Object?> get props => [language, proficiencyLevel];
}

@HiveType(typeId: 1)
class SocialLinkModel extends Equatable {
  @HiveField(0)
  final String socialMedia;

  @HiveField(1)
  final String link;

  const SocialLinkModel(this.socialMedia, this.link);

  @override
  List<Object?> get props => [socialMedia, link];
}

@HiveType(typeId: 0)
class DetailUserLocalModel extends Equatable {
  @HiveField(0)
  final String firstName;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String userName;
  @HiveField(5)
  final String profilePicture;
  @HiveField(6)
  final int completedJobs;
  @HiveField(7)
  final int ongoingJobs;
  @HiveField(8)
  final int cancelledJobs;
  @HiveField(9)
  final int numberOfReviews;
  @HiveField(10)
  final DateTime joinedDate;
  @HiveField(11)
  final List<String> roles;
  @HiveField(12)
  final double earning;
  @HiveField(13)
  final RatingModel skillRating;
  @HiveField(14)
  final RatingModel qualityOfWorkRating;
  @HiveField(15)
  final RatingModel availabilityRating;
  @HiveField(16)
  final RatingModel adherenceToScheduleRating;
  @HiveField(17)
  final RatingModel communicationRating;
  @HiveField(18)
  final RatingModel cooperationRating;
  @HiveField(19)
  final bool isEmailVerified;
  @HiveField(20)
  final bool isPhoneVerified;
  @HiveField(21)
  final double profileCompletedPercentage;
  @HiveField(22)
  final String? gender;
  @HiveField(23)
  final List<String> skills;
  @HiveField(24)
  final String overview;
  @HiveField(25)
  final String expertise;
  @HiveField(26)
  final bool verified;
  @HiveField(27)
  final String available;
  @HiveField(28)
  final AddressModel? address;
  @HiveField(29)
  final List<SocialLinkModel> socialLinks;
  @HiveField(30)
  final List<LanguageModel> languages;
  @HiveField(31)
  final List<EducationModel> educations;
  @HiveField(32)
  final List<EmploymentModel> employments;
  @HiveField(33)
  final List<OtherExperienceModel> otherExperiences;
  @HiveField(34)
  final MainServiceLocalModel? mainService;
  @HiveField(35)
  final bool isProfileComplete;
  @HiveField(36)
  final String id;

  const DetailUserLocalModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.gender,
    required this.skills,
    required this.overview,
    required this.socialLinks,
    required this.languages,
    required this.educations,
    required this.employments,
    required this.otherExperiences,
    required this.completedJobs,
    required this.ongoingJobs,
    required this.cancelledJobs,
    required this.numberOfReviews,
    required this.expertise,
    required this.verified,
    required this.joinedDate,
    required this.profilePicture,
    required this.userName,
    required this.earning,
    required this.skillRating,
    required this.qualityOfWorkRating,
    required this.availabilityRating,
    required this.adherenceToScheduleRating,
    required this.communicationRating,
    required this.cooperationRating,
    required this.roles,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isProfileComplete,
    required this.profileCompletedPercentage,
    required this.available,
    required this.mainService,
    required this.address,
  });
  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        phone,
        email,
        gender,
        skills,
        overview,
        socialLinks,
        address,
        languages,
        educations,
        employments,
        otherExperiences,
        completedJobs,
        ongoingJobs,
        cancelledJobs,
        numberOfReviews,
        expertise,
        verified,
        joinedDate,
        profilePicture,
        userName,
        earning,
        skillRating,
        qualityOfWorkRating,
        availabilityRating,
        adherenceToScheduleRating,
        communicationRating,
        cooperationRating,
        roles,
        isEmailVerified,
        isPhoneVerified,
        isProfileComplete,
        profileCompletedPercentage,
        available,
        mainService,
      ];
}
