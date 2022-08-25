// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_local_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainServiceLocalModelAdapter extends TypeAdapter<MainServiceLocalModel> {
  @override
  final int typeId = 6;

  @override
  MainServiceLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainServiceLocalModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MainServiceLocalModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.subcategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainServiceLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OtherExperienceModelAdapter extends TypeAdapter<OtherExperienceModel> {
  @override
  final int typeId = 5;

  @override
  OtherExperienceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OtherExperienceModel(
      fields[0] as String,
      fields[1] as String,
      id: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OtherExperienceModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OtherExperienceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EmploymentModelAdapter extends TypeAdapter<EmploymentModel> {
  @override
  final int typeId = 4;

  @override
  EmploymentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmploymentModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as RangeDateModel,
      fields[5] as String,
      id: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmploymentModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.company)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.region)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.period)
      ..writeByte(5)
      ..write(obj.summary)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmploymentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EducationModelAdapter extends TypeAdapter<EducationModel> {
  @override
  final int typeId = 3;

  @override
  EducationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EducationModel(
      fields[0] as String,
      fields[1] as RangeDateModel,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      id: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EducationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.institution)
      ..writeByte(1)
      ..write(obj.dateAttended)
      ..writeByte(2)
      ..write(obj.degree)
      ..writeByte(3)
      ..write(obj.areaOfStudy)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LanguageModelAdapter extends TypeAdapter<LanguageModel> {
  @override
  final int typeId = 2;

  @override
  LanguageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.language)
      ..writeByte(1)
      ..write(obj.proficiencyLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SocialLinkModelAdapter extends TypeAdapter<SocialLinkModel> {
  @override
  final int typeId = 1;

  @override
  SocialLinkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocialLinkModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SocialLinkModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.socialMedia)
      ..writeByte(1)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialLinkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DetailUserLocalModelAdapter extends TypeAdapter<DetailUserLocalModel> {
  @override
  final int typeId = 0;

  @override
  DetailUserLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailUserLocalModel(
      id: fields[36] as String,
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      phone: fields[2] as String,
      email: fields[3] as String,
      gender: fields[22] as String?,
      skills: (fields[23] as List).cast<String>(),
      overview: fields[24] as String,
      socialLinks: (fields[29] as List).cast<SocialLinkModel>(),
      languages: (fields[30] as List).cast<LanguageModel>(),
      educations: (fields[31] as List).cast<EducationModel>(),
      employments: (fields[32] as List).cast<EmploymentModel>(),
      otherExperiences: (fields[33] as List).cast<OtherExperienceModel>(),
      completedJobs: fields[6] as int,
      ongoingJobs: fields[7] as int,
      cancelledJobs: fields[8] as int,
      numberOfReviews: fields[9] as int,
      expertise: fields[25] as String,
      verified: fields[26] as bool,
      joinedDate: fields[10] as DateTime,
      profilePicture: fields[5] as String,
      userName: fields[4] as String,
      earning: fields[12] as double,
      skillRating: fields[13] as RatingModel,
      qualityOfWorkRating: fields[14] as RatingModel,
      availabilityRating: fields[15] as RatingModel,
      adherenceToScheduleRating: fields[16] as RatingModel,
      communicationRating: fields[17] as RatingModel,
      cooperationRating: fields[18] as RatingModel,
      roles: (fields[11] as List).cast<String>(),
      isEmailVerified: fields[19] as bool,
      isPhoneVerified: fields[20] as bool,
      isProfileComplete: fields[35] as bool,
      profileCompletedPercentage: fields[21] as double,
      available: fields[27] as String,
      mainService: fields[34] as MainServiceLocalModel?,
      address: fields[28] as AddressModel?,
    );
  }

  @override
  void write(BinaryWriter writer, DetailUserLocalModel obj) {
    writer
      ..writeByte(37)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.userName)
      ..writeByte(5)
      ..write(obj.profilePicture)
      ..writeByte(6)
      ..write(obj.completedJobs)
      ..writeByte(7)
      ..write(obj.ongoingJobs)
      ..writeByte(8)
      ..write(obj.cancelledJobs)
      ..writeByte(9)
      ..write(obj.numberOfReviews)
      ..writeByte(10)
      ..write(obj.joinedDate)
      ..writeByte(11)
      ..write(obj.roles)
      ..writeByte(12)
      ..write(obj.earning)
      ..writeByte(13)
      ..write(obj.skillRating)
      ..writeByte(14)
      ..write(obj.qualityOfWorkRating)
      ..writeByte(15)
      ..write(obj.availabilityRating)
      ..writeByte(16)
      ..write(obj.adherenceToScheduleRating)
      ..writeByte(17)
      ..write(obj.communicationRating)
      ..writeByte(18)
      ..write(obj.cooperationRating)
      ..writeByte(19)
      ..write(obj.isEmailVerified)
      ..writeByte(20)
      ..write(obj.isPhoneVerified)
      ..writeByte(21)
      ..write(obj.profileCompletedPercentage)
      ..writeByte(22)
      ..write(obj.gender)
      ..writeByte(23)
      ..write(obj.skills)
      ..writeByte(24)
      ..write(obj.overview)
      ..writeByte(25)
      ..write(obj.expertise)
      ..writeByte(26)
      ..write(obj.verified)
      ..writeByte(27)
      ..write(obj.available)
      ..writeByte(28)
      ..write(obj.address)
      ..writeByte(29)
      ..write(obj.socialLinks)
      ..writeByte(30)
      ..write(obj.languages)
      ..writeByte(31)
      ..write(obj.educations)
      ..writeByte(32)
      ..write(obj.employments)
      ..writeByte(33)
      ..write(obj.otherExperiences)
      ..writeByte(34)
      ..write(obj.mainService)
      ..writeByte(35)
      ..write(obj.isProfileComplete)
      ..writeByte(36)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailUserLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
