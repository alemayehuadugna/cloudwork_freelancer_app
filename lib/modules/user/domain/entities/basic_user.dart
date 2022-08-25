import 'package:equatable/equatable.dart';

class BasicUser extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String userName;
  final String profilePicture;
  final List<String> roles;
  final bool isEmailVerified;
  final bool isProfileComplete;
  final int completedJobs;
  final int ongoingJobs;
  final int cancelledJobs;
  final int numberOfReviews;

  const BasicUser(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      required this.userName,
      required this.completedJobs,
      required this.cancelledJobs,
      required this.numberOfReviews,
      required this.profilePicture,
      required this.ongoingJobs,
      required this.roles,
      required this.isEmailVerified,
      required this.isProfileComplete});

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        phone,
        email,
        userName,
        profilePicture,
        roles,
        isEmailVerified,
        isProfileComplete
      ];
}
