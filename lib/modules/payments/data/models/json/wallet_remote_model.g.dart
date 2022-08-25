// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletRemoteModel _$WalletRemoteModelFromJson(Map<String, dynamic> json) =>
    WalletRemoteModel(
      (json['balance'] as num).toDouble(),
      (json['inTransaction'] as num).toDouble(),
      (json['invested'] as num).toDouble(),
    );

Map<String, dynamic> _$WalletRemoteModelToJson(WalletRemoteModel instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'inTransaction': instance.inTransaction,
      'invested': instance.inInvestment,
    };
