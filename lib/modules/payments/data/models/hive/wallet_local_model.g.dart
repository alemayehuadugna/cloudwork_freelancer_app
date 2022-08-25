// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletLocalModelAdapter extends TypeAdapter<WalletLocalModel> {
  @override
  final int typeId = 20;

  @override
  WalletLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletLocalModel(
      balance: fields[0] as double,
      inTransaction: fields[1] as double,
      inInvestment: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, WalletLocalModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.balance)
      ..writeByte(1)
      ..write(obj.inTransaction)
      ..writeByte(2)
      ..write(obj.inInvestment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
