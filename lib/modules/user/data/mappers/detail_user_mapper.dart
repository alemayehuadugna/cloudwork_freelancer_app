import '../../../../_shared/data/models/hive/common_model.dart';
import '../../../../_shared/domain/entities/address.dart';
import '../../../../_shared/domain/entities/range_date.dart';
import '../../../../_shared/domain/entities/rating.dart';
import '../../domain/entities/detail_user.dart';
import '../models/hive/detail_local_user_model.dart';
import '../models/json/detail_user_remote_model.dart';

class DetailUserMapper {
  static DetailUserLocalModel toModel(DetailUser user) {
    List<SocialLinkModel> socialLinks = [];
    socialLinks.addAll(
        user.socialLinks.map((e) => SocialLinkModel(e.socialMedia, e.link)));

    List<LanguageModel> languages = [];
    languages.addAll(user.languages
        .map((e) => LanguageModel(e.language, e.proficiencyLevel)));
    List<EducationModel> educations = [];
    educations.addAll(user.educations.map((e) => EducationModel(
        e.institution,
        RangeDateModel(e.dateAttended.start, e.dateAttended.end),
        e.degree,
        e.areaOfStudy,
        e.description,
        id: e.id)));
    List<EmploymentModel> employments = [];
    employments.addAll(user.employments.map((e) => EmploymentModel(
        e.company,
        e.city,
        e.region,
        e.title,
        RangeDateModel(e.period.start, e.period.end),
        e.summary,
        id: e.id)));
    List<OtherExperienceModel> otherExperiences = [];
    otherExperiences.addAll(user.otherExperiences
        .map((e) => OtherExperienceModel(e.subject, e.description, id: e.id)));

    DetailUserLocalModel userModel = DetailUserLocalModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      phone: user.phone,
      email: user.email,
      gender: user.gender,
      skills: user.skills,
      overview: user.overview,
      socialLinks: socialLinks,
      languages: languages,
      educations: educations,
      employments: employments,
      otherExperiences: otherExperiences,
      completedJobs: user.completedJobs,
      ongoingJobs: user.ongoingJobs,
      cancelledJobs: user.cancelledJobs,
      numberOfReviews: user.numberOfReviews,
      expertise: user.expertise,
      verified: user.verified,
      joinedDate: user.joinedDate,
      profilePicture: user.profilePicture,
      userName: user.userName,
      earning: user.earning,
      skillRating: RatingModel(
        user.skillRating.rate,
        user.skillRating.totalRate,
        user.skillRating.totalRaters,
      ),
      qualityOfWorkRating: RatingModel(
        user.qualityOfWorkRating.rate,
        user.qualityOfWorkRating.totalRate,
        user.qualityOfWorkRating.totalRaters,
      ),
      availabilityRating: RatingModel(
        user.availabilityRating.rate,
        user.availabilityRating.totalRate,
        user.availabilityRating.totalRaters,
      ),
      adherenceToScheduleRating: RatingModel(
        user.adherenceToScheduleRating.rate,
        user.adherenceToScheduleRating.totalRate,
        user.adherenceToScheduleRating.totalRaters,
      ),
      communicationRating: RatingModel(
        user.communicationRating.rate,
        user.communicationRating.totalRate,
        user.communicationRating.totalRaters,
      ),
      cooperationRating: RatingModel(
        user.cooperationRating.rate,
        user.cooperationRating.totalRate,
        user.cooperationRating.totalRaters,
      ),
      roles: user.roles,
      isEmailVerified: user.isEmailVerified,
      isPhoneVerified: user.isPhoneVerified,
      isProfileComplete: user.isProfileComplete,
      profileCompletedPercentage: user.profileCompletedPercentage,
      available: user.available,
      address: user.address != null
          ? AddressModel(
              user.address!.region,
              user.address!.city,
              user.address?.areaName,
              user.address?.postalCode,
            )
          : null,
      mainService: user.mainService != null
          ? MainServiceLocalModel(
              user.mainService!.category,
              user.mainService!.subcategory,
            )
          : null,
    );
    return userModel;
  }

  static DetailUser toEntity(DetailUserLocalModel userModel) {
    List<SocialLink> socialLinks = [];
    socialLinks.addAll(
        userModel.socialLinks.map((e) => SocialLink(e.socialMedia, e.link)));
    List<Language> languages = [];
    languages.addAll(userModel.languages
        .map((e) => Language(e.language, e.proficiencyLevel)));
    List<Education> educations = [];
    educations.addAll(userModel.educations.map((e) => Education(
        e.institution,
        RangeDate(e.dateAttended.start, e.dateAttended.end),
        e.degree,
        e.areaOfStudy,
        e.description,
        id: e.id)));
    List<Employment> employments = [];
    employments.addAll(userModel.employments.map((e) => Employment(
        e.company,
        e.city,
        e.region,
        e.title,
        RangeDate(e.period.start, e.period.end),
        e.summary,
        id: e.id)));
    List<OtherExperience> otherExperiences = [];
    otherExperiences.addAll(userModel.otherExperiences
        .map((e) => OtherExperience(e.subject, e.description, id: e.id)));

    DetailUser user = DetailUser(
      userModel.address != null
          ? Address(userModel.address!.region, userModel.address!.city,
              userModel.address?.areaName, userModel.address?.postalCode)
          : null,
      userModel.mainService != null
          ? MainService(
              userModel.mainService!.category,
              userModel.mainService!.subcategory,
            )
          : null,
      id: userModel.id,
      firstName: userModel.firstName,
      lastName: userModel.lastName,
      phone: userModel.phone,
      email: userModel.email,
      gender: userModel.gender,
      skills: userModel.skills,
      overview: userModel.overview,
      socialLinks: socialLinks,
      languages: languages,
      educations: educations,
      employments: employments,
      otherExperiences: otherExperiences,
      completedJobs: userModel.completedJobs,
      ongoingJobs: userModel.ongoingJobs,
      cancelledJobs: userModel.cancelledJobs,
      numberOfReviews: userModel.numberOfReviews,
      expertise: userModel.expertise,
      verified: userModel.verified,
      joinedDate: userModel.joinedDate,
      profilePicture: userModel.profilePicture,
      userName: userModel.userName,
      earning: userModel.earning,
      skillRating: Rating(
        userModel.skillRating.rate,
        userModel.skillRating.totalRate,
        userModel.skillRating.totalRaters,
      ),
      qualityOfWorkRating: Rating(
        userModel.qualityOfWorkRating.rate,
        userModel.qualityOfWorkRating.totalRate,
        userModel.qualityOfWorkRating.totalRaters,
      ),
      availabilityRating: Rating(
        userModel.availabilityRating.rate,
        userModel.availabilityRating.totalRate,
        userModel.availabilityRating.totalRaters,
      ),
      adherenceToScheduleRating: Rating(
        userModel.adherenceToScheduleRating.rate,
        userModel.adherenceToScheduleRating.totalRate,
        userModel.adherenceToScheduleRating.totalRaters,
      ),
      communicationRating: Rating(
        userModel.communicationRating.rate,
        userModel.communicationRating.totalRate,
        userModel.communicationRating.totalRaters,
      ),
      cooperationRating: Rating(
        userModel.cooperationRating.rate,
        userModel.cooperationRating.totalRate,
        userModel.cooperationRating.totalRaters,
      ),
      roles: userModel.roles,
      available: '',
      isEmailVerified: userModel.isEmailVerified,
      isPhoneVerified: userModel.isPhoneVerified,
      isProfileComplete: userModel.isProfileComplete,
      profileCompletedPercentage: userModel.profileCompletedPercentage,
    );
    return user;
  }

  static DetailUser fromJosn(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var user;
    List<SocialLink> socialLinks = [];
    List<Language> languages = [];
    List<Education> educations = [];
    List<Employment> employments = [];
    List<OtherExperience> otherExperiences = [];
    try {
      user = DetailUserRemoteModel.fromJson(json);
      user.socialLinks.forEach((e) {
        socialLinks.add(SocialLink(e.socialMedia, e.link));
      });
      user.languages.forEach((e) {
        languages.add(Language(e.language, e.proficiencyLevel));
      });
      user.educations.forEach((edu) {
        educations.add(Education(
            edu.institution,
            RangeDate(edu.dateAttended.start, edu.dateAttended.end),
            edu.degree,
            edu.areaOfStudy,
            edu.description,
            id: edu.id));
      });

      user.employments.forEach((e) {
        employments.add(Employment(e.company, e.city, e.region, e.title,
            RangeDate(e.period.start, e.period.end), e.summary,
            id: e.id));
      });
      user.otherExperiences.forEach((e) {
        otherExperiences.add(OtherExperience(
          e.subject,
          e.description,
          id: e.id,
        ));
      });
    } catch (e) {
      // ignore: avoid_print
      print("in user mapper catch => $e");
    }

    final DetailUser detailUser = DetailUser(
      user.address != null
          ? Address(
              user.address.region,
              user.address.city,
              user.address.areaName,
              user.address.postalCode,
            )
          : null,
      user.mainService != null
          ? MainService(
              user.mainService.category,
              user.mainService.subcategory,
            )
          : null,
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      phone: user.phone,
      email: user.email,
      gender: user.gender,
      skills: user.skills,
      overview: user.overview,
      socialLinks: socialLinks,
      languages: languages,
      educations: educations,
      employments: employments,
      otherExperiences: otherExperiences,
      completedJobs: user.completedJobs,
      ongoingJobs: user.ongoingJobs,
      cancelledJobs: user.cancelledJobs,
      numberOfReviews: user.numberOfReviews,
      expertise: user.expertise,
      verified: user.verified,
      joinedDate: user.joinedDate,
      profilePicture: user.profilePicture,
      userName: user.userName,
      earning: user.earning,
      skillRating: Rating(
        user.skillRating.rate,
        user.skillRating.totalRate,
        user.skillRating.totalRaters,
      ),
      qualityOfWorkRating: Rating(
        user.qualityOfWorkRating.rate,
        user.qualityOfWorkRating.totalRate,
        user.qualityOfWorkRating.totalRaters,
      ),
      availabilityRating: Rating(
        user.availabilityRating.rate,
        user.availabilityRating.totalRate,
        user.availabilityRating.totalRaters,
      ),
      adherenceToScheduleRating: Rating(
        user.adherenceToScheduleRating.rate,
        user.adherenceToScheduleRating.totalRate,
        user.adherenceToScheduleRating.totalRaters,
      ),
      communicationRating: Rating(
        user.communicationRating.rate,
        user.communicationRating.totalRate,
        user.communicationRating.totalRaters,
      ),
      cooperationRating: Rating(
        user.cooperationRating.rate,
        user.cooperationRating.totalRate,
        user.cooperationRating.totalRaters,
      ),
      roles: user.roles,
      available: user.available,
      isEmailVerified: user.isEmailVerified,
      isPhoneVerified: user.isPhoneVerified,
      isProfileComplete: user.isProfileComplete,
      profileCompletedPercentage: user.profileCompletedPercentage,
    );
    return detailUser;
  }
}
