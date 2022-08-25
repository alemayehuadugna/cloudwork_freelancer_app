import 'package:json_annotation/json_annotation.dart';

part 'basic_remote_user.g.dart';

@JsonSerializable()
class BasicRemoteUser {
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

  BasicRemoteUser(
      this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.userName,
      this.completedJobs,
      this.ongoingJobs,
      this.cancelledJobs,
      this.numberOfReviews,
      this.profilePicture,
      this.roles,
      this.isEmailVerified,
      this.isProfileComplete);

  factory BasicRemoteUser.fromJson(Map<String, dynamic> json) =>
      _$BasicRemoteUserFromJson(json);

  Map<String, dynamic> toJson() => _$BasicRemoteUserToJson(this);
}
