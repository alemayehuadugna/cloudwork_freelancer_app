import '../../domain/entities/basic_user.dart';
import '../models/hive/basic_local_user.dart';
import '../models/json/basic_remote_user.dart';

class BasicUserMapper {
  static BasicLocalUser toModel(BasicUser user) {
    return BasicLocalUser(
        user.id,
        user.firstName,
        user.lastName,
        user.phone,
        user.email,
        user.profilePicture,
        user.cancelledJobs,
        user.ongoingJobs,
        user.completedJobs,
        user.numberOfReviews,
        user.userName,
        user.isEmailVerified,
        user.isProfileComplete,
        user.roles);
  }

  static BasicUser toEntity(BasicLocalUser model) {
    return BasicUser(
        id: model.id,
        firstName: model.firstName,
        lastName: model.lastName,
        phone: model.phone,
        email: model.email,
        userName: model.userName,
        profilePicture: model.profilePicture,
        completedJobs: model.completedJobs,
        cancelledJobs: model.cancelledJobs,
        ongoingJobs: model.ongoingJobs,
        numberOfReviews: model.numberOfReviews,
        roles: model.roles,
        isEmailVerified: model.isEmailVerified,
        isProfileComplete: model.isProfileComplete);
  }

  static BasicUser fromJson(Map<String, dynamic> json) {
    var user;
    try {
      user = BasicRemoteUser.fromJson(json);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return BasicUser(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        phone: user.phone,
        email: user.email,
        userName: user.userName,
        profilePicture: user.profilePicture,
        completedJobs: user.completedJobs,
        cancelledJobs: user.cancelledJobs,
        ongoingJobs: user.ongoingJobs,
        numberOfReviews: user.numberOfReviews,
        roles: user.roles,
        isEmailVerified: user.isEmailVerified,
        isProfileComplete: user.isProfileComplete);
  }
}
