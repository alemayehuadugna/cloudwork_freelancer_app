// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_local_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasicLocalUserAdapter extends TypeAdapter<BasicLocalUser> {
  @override
  final int typeId = 12;

  @override
  BasicLocalUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasicLocalUser(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[12] as int,
      fields[11] as int,
      fields[10] as int,
      fields[13] as int,
      fields[6] as String,
      fields[7] as bool,
      fields[8] as bool,
      (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BasicLocalUser obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.profilePicture)
      ..writeByte(6)
      ..write(obj.userName)
      ..writeByte(7)
      ..write(obj.isEmailVerified)
      ..writeByte(8)
      ..write(obj.isProfileComplete)
      ..writeByte(9)
      ..write(obj.roles)
      ..writeByte(10)
      ..write(obj.completedJobs)
      ..writeByte(11)
      ..write(obj.ongoingJobs)
      ..writeByte(12)
      ..write(obj.cancelledJobs)
      ..writeByte(13)
      ..write(obj.numberOfReviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasicLocalUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
