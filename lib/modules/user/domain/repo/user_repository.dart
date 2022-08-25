import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_shared/domain/entities/address.dart';
import '../entities/basic_user.dart';
import '../entities/detail_user.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> authenticate(
      {required String phone, required String password});

  Future<Either<Failure, bool>> isAuthenticated();

  Future<Either<Failure, BasicUser>> getCurrentUser();

  Future<Either<Failure, DetailUser>> getDetailUser();

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, String>> register(payload);

  Future<Either<Failure, void>> forgetPassword();

  Future<Either<Failure, void>> verifyEmail(
      {required String code, required String email});

  Future<Either<Failure, void>> addExpertise({required String expertise});

  Future<Either<Failure, void>> resendOTP({required String email});

  Future<Either<Failure, Employment>> saveEmployment(
      {required Employment employment});

  Future<Either<Failure, String>> removeEmployment(
      {required String employmentId});

  Future<Either<Failure, Education>> saveEducation(
      {required Education education});

  Future<Either<Failure, String>> removeEducation(
      {required String educationId});

  Future<Either<Failure, void>> saveLanguages(
      {required List<Language> languages});

  Future<Either<Failure, void>> saveSkills({required List<String> skills});

  Future<Either<Failure, void>> saveOverview({required String overview});

  Future<Either<Failure, void>> saveMainService(
      {required String category, required String subcategory});

  Future<Either<Failure, String>> uploadProfilePicture({required var file});

  Future<Either<Failure, void>> saveBasicInfo(
      Address address, String available, String gender);

  Future<Either<Failure, void>> changeAvailability(String available);

  Future<Either<Failure, OtherExperience>> saveOtherExperience(
      {required OtherExperience otherExperience});

  Future<Either<Failure, String>> removeOtherExperience({required String id});

  Future<Either<Failure, void>> changePassword(
      {required String oldPassword, required String newPassword});

  Future<Either<Failure, void>> deleteAccount(
      {required String reason, required String password});
}
