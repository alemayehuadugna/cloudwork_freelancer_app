// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProposalFreelancerHiveModelAdapter
    extends TypeAdapter<ProposalFreelancerHiveModel> {
  @override
  final int typeId = 4;

  @override
  ProposalFreelancerHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProposalFreelancerHiveModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProposalFreelancerHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.profilePicture)
      ..writeByte(3)
      ..write(obj.numberOfReviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProposalFreelancerHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BidHiveModelAdapter extends TypeAdapter<BidHiveModel> {
  @override
  final int typeId = 3;

  @override
  BidHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BidHiveModel(
      fields[0] as String,
      fields[1] as double,
      fields[2] as int,
      fields[3] as String,
      fields[4] as bool,
      fields[5] as DateTime,
      fields[6] as ProposalFreelancerHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, BidHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.freelancerId)
      ..writeByte(1)
      ..write(obj.budget)
      ..writeByte(2)
      ..write(obj.hours)
      ..writeByte(3)
      ..write(obj.coverLetter)
      ..writeByte(4)
      ..write(obj.isTermsAndConditionAgreed)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.freelancer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BidHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClientHiveModelAdapter extends TypeAdapter<ClientHiveModel> {
  @override
  final int typeId = 2;

  @override
  ClientHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientHiveModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ClientHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.clientId)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.profilePicture)
      ..writeByte(4)
      ..write(obj.completedJobs)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class JobHiveModelAdapter extends TypeAdapter<JobHiveModel> {
  @override
  final int typeId = 1;

  @override
  JobHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobHiveModel(
      fields[0] as String,
      (fields[1] as List?)?.cast<ClientHiveModel>(),
      fields[2] as String?,
      fields[3] as String,
      (fields[4] as List).cast<String>(),
      fields[5] as double,
      fields[6] as int,
      fields[7] as int,
      fields[8] as String?,
      fields[9] as String,
      fields[10] as String?,
      fields[11] as String,
      fields[12] as DateTime,
      (fields[13] as List).cast<BidHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, JobHiveModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.clientId)
      ..writeByte(2)
      ..write(obj.freelancerId)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.skills)
      ..writeByte(5)
      ..write(obj.budget)
      ..writeByte(6)
      ..write(obj.proposals)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.expiry)
      ..writeByte(9)
      ..write(obj.category)
      ..writeByte(10)
      ..write(obj.language)
      ..writeByte(11)
      ..write(obj.progress)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.bid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
