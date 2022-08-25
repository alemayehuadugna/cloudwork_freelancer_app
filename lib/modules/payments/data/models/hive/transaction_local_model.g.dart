// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionLocalModelAdapter extends TypeAdapter<TransactionLocalModel> {
  @override
  final int typeId = 22;

  @override
  TransactionLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionLocalModel(
      fields[0] as String,
      fields[1] as double,
      fields[2] as String,
      fields[3] as String,
      fields[4] as TransactionByLocalModel,
      fields[5] as String?,
      fields[6] as String,
      fields[7] as String,
      fields[8] as double,
      fields[9] as String,
      fields[10] as String,
      fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionLocalModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.tnxId)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.tnxFrom)
      ..writeByte(4)
      ..write(obj.tnxBy)
      ..writeByte(5)
      ..write(obj.remark)
      ..writeByte(6)
      ..write(obj.tnxTo)
      ..writeByte(7)
      ..write(obj.tnxType)
      ..writeByte(8)
      ..write(obj.serviceCharge)
      ..writeByte(9)
      ..write(obj.tnxNumber)
      ..writeByte(10)
      ..write(obj.invoiceImageUrl)
      ..writeByte(11)
      ..write(obj.tnxTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionByLocalModelAdapter
    extends TypeAdapter<TransactionByLocalModel> {
  @override
  final int typeId = 23;

  @override
  TransactionByLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionByLocalModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionByLocalModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.transferredThrough)
      ..writeByte(1)
      ..write(obj.accountNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionByLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
