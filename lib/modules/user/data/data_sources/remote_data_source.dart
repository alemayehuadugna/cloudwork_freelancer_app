import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../_shared/domain/entities/address.dart';
import '../../domain/entities/basic_user.dart';
import '../../domain/entities/detail_user.dart';
import '../mappers/basic_user_mapper.dart';
import '../mappers/detail_user_mapper.dart';
import '../models/json/detail_user_remote_model.dart';

abstract class UserRemoteDataSource {
  Future<BasicUser> getBasicUser();

  Future<DetailUser> getDetailUser();

  Future<String> authenticate(String phone, String password);

  Future<String> register(payload);

  Future<String> verifyEmail(String code, String email);

  Future<void> resendOTP(String email);

  Future<void> addExpertise(String expertise);

  Future<void> saveLanguages(List<Language> languages);

  Future<void> saveSkills(List<String> skills);

  Future<void> saveOverview(String overview);

  Future<void> saveMainService(String category, String subcategory);

  Future<void> saveAddress(Address address);

  Future<void> saveBasicInfo(String available, String gender);

  Future<String> uploadProfilePicture(final file);

  Future<void> changeAvailability(String available);

  Future<void> changePassword(String oldPassword, String newPassword);

  Future<void> deleteAccount(String reason, String password);

  Future<EmploymentRemoteModel> addEmployment(Employment employment);
  Future<EmploymentRemoteModel> editEmployment(
      String id, Employment employment);
  Future<void> removeEmployment(String id);

  Future<EducationRemoteModel> addEducation(Education education);
  Future<EducationRemoteModel> editEducation(String id, Education education);
  Future<void> removeEducation(String id);

  Future<OtherExperienceRemoteModel> addOtherExperience(
      OtherExperience otherExperience);
  Future<OtherExperienceRemoteModel> editOtherExperience(
      String id, OtherExperience otherExperience);
  Future<void> removeOtherExperience(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> authenticate(String phone, String password) async {
    String path = "/freelancers/login";
    final data = {'email': phone, 'password': password};
    final response = await dio.post(path, data: data);
    return response.data;
  }

  @override
  Future<String> verifyEmail(String code, String email) async {
    String path = '/freelancers/me/verify/email';
    final response = await dio.post(path, data: {'code': code, 'email': email});
    return response.data['token'];
  }

  @override
  Future<BasicUser> getBasicUser() async {
    String path = '/freelancers/me/basic';
    final response = await dio.get(path);
    return BasicUserMapper.fromJson(response.data['data']);
  }

  @override
  Future<DetailUser> getDetailUser() async {
    String path = '/freelancers/me/detail';
    final response = await dio.get(path);
    return DetailUserMapper.fromJosn(response.data['data']);
  }

  @override
  Future<String> register(payload) async {
    String path = '/freelancers';
    final response = await dio.post(path, data: payload);
    return response.data['data'];
  }

  @override
  Future<void> resendOTP(String email) async {
    String path = '/freelancers/me/otp/verification';
    await dio.post(path, data: {'email': email});
    return;
  }

  @override
  Future<void> addExpertise(String expertise) async {
    String path = '/freelancers/me/expertise';
    await dio.patch(path, data: {'expertise': expertise});
    return;
  }

  @override
  Future<EmploymentRemoteModel> addEmployment(Employment employment) async {
    String path = '/freelancers/me/employments';
    final response = await dio.post(path,
        data: EmploymentRemoteModel(
          employment.company,
          employment.city,
          employment.region,
          employment.title,
          RangeDateRemoteModel(employment.period.start, employment.period.end),
          employment.summary,
        ).toJson());
    return EmploymentRemoteModel.fromJson(response.data['data']);
  }

  @override
  Future<EmploymentRemoteModel> editEmployment(
      String id, Employment employment) async {
    String path = '/freelancers/me/employments/$id';
    final response = await dio.patch(path,
        data: EmploymentRemoteModel(
          employment.company,
          employment.city,
          employment.region,
          employment.title,
          RangeDateRemoteModel(employment.period.start, employment.period.end),
          employment.summary,
        ).toJson());
    return EmploymentRemoteModel.fromJson(response.data['data']);
  }

  @override
  Future<void> removeEmployment(String id) async {
    String path = '/freelancers/me/employments/$id';
    await dio.delete(path);
    return;
  }

  @override
  Future<EducationRemoteModel> addEducation(Education education) async {
    String path = '/freelancers/me/educations';
    final response = await dio.post(path,
        data: EducationRemoteModel(
          education.institution,
          RangeDateRemoteModel(
              education.dateAttended.start, education.dateAttended.end),
          education.degree,
          education.areaOfStudy,
          education.description,
        ).toJson());
    return EducationRemoteModel.fromJson(response.data['data']);
  }

  @override
  Future<EducationRemoteModel> editEducation(
    String id,
    Education education,
  ) async {
    String path = '/freelancers/me/educations/$id';
    final response = await dio.patch(path,
        data: EducationRemoteModel(
          education.institution,
          RangeDateRemoteModel(
            education.dateAttended.start,
            education.dateAttended.end,
          ),
          education.degree,
          education.areaOfStudy,
          education.description,
        ).toJson());
    return EducationRemoteModel.fromJson(response.data['data']);
  }

  @override
  Future<void> removeEducation(String id) async {
    String path = '/freelancers/me/educations/$id';
    await dio.delete(path);
    return;
  }

  @override
  Future<void> saveLanguages(List<Language> languages) async {
    String path = '/freelancers/me/languages';
    List<LanguageRemoteModel> remoteLanguages = [];
    remoteLanguages.addAll(languages
        .map((e) => LanguageRemoteModel(e.language, e.proficiencyLevel)));
    await dio.patch(path, data: {'languages': remoteLanguages});
    return;
  }

  @override
  Future<void> saveSkills(List<String> skills) async {
    String path = '/freelancers/me/skills';
    await dio.patch(path, data: {'skills': skills});
    return;
  }

  @override
  Future<void> saveOverview(String overview) async {
    String path = '/freelancers/me/overview';
    await dio.patch(path, data: {'overview': overview});
    return;
  }

  @override
  Future<void> saveMainService(String category, String subcategory) async {
    String path = '/freelancers/me/main-service';
    await dio.patch(path, data: {
      'category': category,
      'subcategory': subcategory,
    });
    return;
  }

  @override
  Future<String> uploadProfilePicture(final file) async {
    String path = '/freelancers/me/picture';
    final upload = file as PlatformFile;
    MultipartFile fileToUpload;
    if (kIsWeb) {
      fileToUpload = MultipartFile.fromBytes(
        upload.bytes!,
        filename: upload.name,
        contentType: MediaType('image', upload.extension!),
      );
    } else {
      final fileBytes = await File(upload.path!).readAsBytes();
      fileToUpload = MultipartFile.fromBytes(
        fileBytes,
        filename: upload.name,
        contentType: MediaType('image', upload.extension!),
      );
    }

    final formData = FormData.fromMap({'profilePicture': fileToUpload});
    final response = await dio.patch(path, data: formData);

    return response.data['data'];
  }

  @override
  Future<void> saveAddress(Address address) async {
    String path = "/freelancers/me/address";
    await dio.patch(path,
        data: AddressRemoteModel(
          address.region,
          address.city,
          address.areaName,
          address.postalCode,
        ).toJson());
    return;
  }

  @override
  Future<void> saveBasicInfo(String available, String gender) async {
    String path = "/freelancers/me/basic";
    await dio.patch(path, data: {
      "available": available,
      "gender": gender,
    });
    return;
  }

  @override
  Future<void> changeAvailability(String available) async {
    String path = "/freelancers/me/availability";
    await dio.patch(path, data: {"available": available});
    return;
  }

  @override
  Future<OtherExperienceRemoteModel> addOtherExperience(
      OtherExperience otherExperience) async {
    String path = "/freelancers/me/other-experiences";
    final response = await dio.post(path,
        data: OtherExperienceRemoteModel(
          otherExperience.subject,
          otherExperience.description,
        ).toJson());
    return OtherExperienceRemoteModel.fromJson(response.data);
  }

  @override
  Future<OtherExperienceRemoteModel> editOtherExperience(
      String id, OtherExperience otherExperience) async {
    String path = "/freelancers/me/other-experiences/$id";
    final response = await dio.patch(path,
        data: OtherExperienceRemoteModel(
          otherExperience.subject,
          otherExperience.description,
        ).toJson());

    return OtherExperienceRemoteModel.fromJson(
        response.data['data']['otherExperience']);
  }

  @override
  Future<void> removeOtherExperience(String id) async {
    String path = '/freelancers/me/other-experiences/$id';
    await dio.delete(path);
    return;
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    String path = "/freelancers/me/change-password";
    await dio.patch(
      path,
      data: {"oldPassword": oldPassword, "newPassword": newPassword},
    );
    return;
  }

  @override
  Future<void> deleteAccount(String reason, String password) async {
    String path = "/freelancers/me/delete";
    await dio.delete(
      path,
      data: {"reason": reason, "password": password},
    );
    return;
  }
}
