// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionRemoteModel _$TransactionRemoteModelFromJson(
        Map<String, dynamic> json) =>
    TransactionRemoteModel(
      TransactionRemoteModel.parseId(json['id']),
      (json['amount'] as num).toDouble(),
      json['status'] as String,
      json['tnxFrom'] as String,
      TransactionByRemoteModel.fromJson(json['tnxBy'] as Map<String, dynamic>),
      json['remark'] as String?,
      json['tnxTo'] as String,
      json['tnxType'] as String,
      (json['serviceCharge'] as num).toDouble(),
      json['tnxNumber'] as String,
      json['invoiceImageUrl'] as String,
      DateTime.parse(json['tnxTime'] as String),
    );

Map<String, dynamic> _$TransactionRemoteModelToJson(
        TransactionRemoteModel instance) =>
    <String, dynamic>{
      'id': instance.tnxId,
      'amount': instance.amount,
      'status': instance.status,
      'tnxFrom': instance.tnxFrom,
      'tnxBy': instance.tnxBy,
      'remark': instance.remark,
      'tnxTo': instance.tnxTo,
      'tnxType': instance.tnxType,
      'serviceCharge': instance.serviceCharge,
      'tnxNumber': instance.tnxNumber,
      'invoiceImageUrl': instance.invoiceImageUrl,
      'tnxTime': instance.tnxTime.toIso8601String(),
    };

TransactionByRemoteModel _$TransactionByRemoteModelFromJson(
        Map<String, dynamic> json) =>
    TransactionByRemoteModel(
      json['transferredThrough'] as String,
      json['accountNumber'] as String,
    );

Map<String, dynamic> _$TransactionByRemoteModelToJson(
        TransactionByRemoteModel instance) =>
    <String, dynamic>{
      'transferredThrough': instance.transferredThrough,
      'accountNumber': instance.accountNumber,
    };
