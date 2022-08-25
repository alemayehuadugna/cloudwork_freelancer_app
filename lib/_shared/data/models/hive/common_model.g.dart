// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RatingModelAdapter extends TypeAdapter<RatingModel> {
  @override
  final int typeId = 8;

  @override
  RatingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RatingModel(
      fields[0] as double,
      fields[1] as double,
      fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, RatingModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.rate)
      ..writeByte(1)
      ..write(obj.totalRate)
      ..writeByte(2)
      ..write(obj.totalRaters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RangeDateModelAdapter extends TypeAdapter<RangeDateModel> {
  @override
  final int typeId = 9;

  @override
  RangeDateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RangeDateModel(
      fields[0] as DateTime,
      fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RangeDateModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RangeDateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressModelAdapter extends TypeAdapter<AddressModel> {
  @override
  final int typeId = 10;

  @override
  AddressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String?,
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.region)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.areaName)
      ..writeByte(3)
      ..write(obj.postalCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
