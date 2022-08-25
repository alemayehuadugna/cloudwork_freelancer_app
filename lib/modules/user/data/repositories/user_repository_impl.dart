import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../_core/error/exceptions.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_shared/domain/entities/address.dart';
import '../../../../_shared/domain/entities/range_date.dart';
import '../../domain/entities/basic_user.dart';
import '../../domain/entities/detail_user.dart';
import '../../domain/repo/user_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../mappers/basic_user_mapper.dart';
import '../mappers/detail_user_mapper.dart';
import '../models/json/create_remote_user.dart';
import '../models/json/detail_user_remote_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  // final ChatLocalDataSource chatLocalDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    // required this.chatLocalDataSource,
  });

  @override
  Future<Either<Failure, String>> authenticate({
    required String phone,
    required String password,
  }) async {
    try {
      final token = await remoteDataSource.authenticate(phone, password);
      localDataSource.cacheToken(token);
      return Right(token);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail(
      {required String code, required String email}) async {
    try {
      final token = await remoteDataSource.verifyEmail(code, email);
      localDataSource.cacheToken(token);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure("unknown server error"));
    }
  }

  @override
  Future<Either<Failure, void>> resendOTP({required String email}) async {
    try {
      await remoteDataSource.resendOTP(email);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, String>> register(payload) async {
    try {
      final freelancerId = await remoteDataSource.register(CreateUser(
        payload.firstName,
        payload.lastName,
        payload.phone,
        payload.email,
        payload.password,
        payload.hasAgreed,
      ).toJson());
      return Right(freelancerId);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure('Registration Not Successful'));
      }
      return Left(ServerFailure("unknown server error"));
    }
  }

  @override
  Future<Either<Failure, BasicUser>> getCurrentUser() async {
    try {
      final remoteUser = await remoteDataSource.getBasicUser();
      localDataSource.cacheBasicUser(BasicUserMapper.toModel(remoteUser));
      return Right(remoteUser);
    } catch (err) {
      try {
        final localUser = await localDataSource.getCachedBasicUser();
        return Right(localUser);
      } on CacheException {
        return Left(CacheFailure("error on cache"));
      }
    }
  }

  @override
  Future<Either<Failure, DetailUser>> getDetailUser() async {
    try {
      final remoteDetailUser = await remoteDataSource.getDetailUser();
      localDataSource
          .cacheDetailUser(DetailUserMapper.toModel(remoteDetailUser));
      return Right(remoteDetailUser);
    } catch (err) {
      try {
        final localDetailUser = await localDataSource.getCachedDetailUser();
        return Right(localDetailUser);
      } on CacheException {
        return Left(CacheFailure('error on cache'));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await localDataSource.getCachedToken();
      if (token.isNotEmpty) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on CacheException {
      return Left(CacheFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await localDataSource.removeToken();
      await localDataSource.removeBasicUser();
      // await chatLocalDataSource.
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> addExpertise(
      {required String expertise}) async {
    try {
      await remoteDataSource.addExpertise(expertise);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, Employment>> saveEmployment(
      {required Employment employment}) async {
    try {
      final EmploymentRemoteModel remoteEmployment;
      if (employment.id == null) {
        remoteEmployment = await remoteDataSource.addEmployment(employment);
      } else {
        remoteEmployment =
            await remoteDataSource.editEmployment(employment.id!, employment);
      }
      return Right(Employment(
        remoteEmployment.company,
        remoteEmployment.city,
        remoteEmployment.region,
        remoteEmployment.title,
        RangeDate(remoteEmployment.period.start, remoteEmployment.period.end),
        remoteEmployment.summary,
        id: remoteEmployment.id,
      ));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, String>> removeEmployment(
      {required String employmentId}) async {
    try {
      await remoteDataSource.removeEmployment(employmentId);
      return Right(employmentId);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, String>> removeEducation(
      {required String educationId}) async {
    try {
      await remoteDataSource.removeEducation(educationId);
      return Right(educationId);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, Education>> saveEducation(
      {required Education education}) async {
    try {
      final EducationRemoteModel remoteEducation;
      if (education.id == null) {
        remoteEducation = await remoteDataSource.addEducation(education);
      } else {
        remoteEducation =
            await remoteDataSource.editEducation(education.id!, education);
      }
      return Right(Education(
        remoteEducation.institution,
        RangeDate(
          remoteEducation.dateAttended.start,
          remoteEducation.dateAttended.end,
        ),
        remoteEducation.degree,
        remoteEducation.areaOfStudy,
        remoteEducation.description,
        id: remoteEducation.id,
      ));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, void>> saveLanguages(
      {required List<Language> languages}) async {
    try {
      await remoteDataSource.saveLanguages(languages);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, void>> saveSkills(
      {required List<String> skills}) async {
    try {
      await remoteDataSource.saveSkills(skills);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, void>> saveOverview({required String overview}) async {
    try {
      await remoteDataSource.saveOverview(overview);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, void>> saveMainService(
      {required String category, required String subcategory}) async {
    try {
      await remoteDataSource.saveMainService(category, subcategory);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(
      {required final file}) async {
    try {
      String profilePictureUrl =
          await remoteDataSource.uploadProfilePicture(file);
      return Right(profilePictureUrl);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error when uploading picture'));
    }
  }

  @override
  Future<Either<Failure, void>> saveBasicInfo(
      Address address, String available, String gender) async {
    try {
      await remoteDataSource.saveAddress(address);
      try {
        await remoteDataSource.saveBasicInfo(available, gender);
        return const Right(null);
      } catch (err) {
        if (err is DioError) {
          return Left(ServerFailure(err.response!.data['message']));
        }
        return Left(
            ServerFailure('unknown server error when saving basic info'));
      }
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error when saving address'));
    }
  }

  @override
  Future<Either<Failure, void>> changeAvailability(String available) async {
    try {
      await remoteDataSource.changeAvailability(available);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error when saving address'));
    }
  }

  @override
  Future<Either<Failure, String>> removeOtherExperience(
      {required String id}) async {
    try {
      await remoteDataSource.removeOtherExperience(id);
      return Right(id);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'
          ' when removing other experience'));
    }
  }

  @override
  Future<Either<Failure, OtherExperience>> saveOtherExperience(
      {required OtherExperience otherExperience}) async {
    try {
      final OtherExperienceRemoteModel remoteOtherExperience;
      if (otherExperience.id == null) {
        remoteOtherExperience =
            await remoteDataSource.addOtherExperience(otherExperience);
      } else {
        remoteOtherExperience = await remoteDataSource.editOtherExperience(
            otherExperience.id!, otherExperience);
      }
      return Right(OtherExperience(
        remoteOtherExperience.subject,
        remoteOtherExperience.description,
        id: remoteOtherExperience.id,
      ));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'
          ' when saving other experience'));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      await remoteDataSource.changePassword(oldPassword, newPassword);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(
          ServerFailure("unknown server error while changing password"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(
      {required String reason, required String password}) async {
    try {
      await remoteDataSource.deleteAccount(reason, password);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(
          ServerFailure("unknown server error while deleting your account"));
    }
  }
}
