import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'basic_local_user.g.dart';

@HiveType(typeId: 12)
class BasicLocalUser extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String profilePicture;

  @HiveField(6)
  final String userName;

  @HiveField(7)
  final bool isEmailVerified;

  @HiveField(8)
  final bool isProfileComplete;

  @HiveField(9)
  final List<String> roles;

  @HiveField(10)
  final int completedJobs;
  @HiveField(11)
  final int ongoingJobs;
  @HiveField(12)
  final int cancelledJobs;
  @HiveField(13)
  final int numberOfReviews;

  const BasicLocalUser(
      this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.profilePicture,
      this.cancelledJobs,
      this.ongoingJobs,
      this.completedJobs,
      this.numberOfReviews,
      this.userName,
      this.isEmailVerified,
      this.isProfileComplete,
      this.roles);

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        phone,
        email,
        profilePicture,
        userName,
        isEmailVerified,
        isProfileComplete,
        roles
      ];
}
