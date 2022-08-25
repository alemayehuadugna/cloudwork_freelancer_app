import 'package:json_annotation/json_annotation.dart';

part 'transaction_remote_model.g.dart';

@JsonSerializable()
class TransactionRemoteModel {
  static parseId(objectId) => objectId['value'];
  @JsonKey(fromJson: parseId, includeIfNull: false, name: "id")
  final String tnxId;
  final double amount;
  final String status;
  final String tnxFrom;
  final TransactionByRemoteModel tnxBy;
  final String? remark;
  final String tnxTo;
  final String tnxType;
  final double serviceCharge;
  final String tnxNumber;
  final String invoiceImageUrl;
  final DateTime tnxTime;

  TransactionRemoteModel(
      this.tnxId,
      this.amount,
      this.status,
      this.tnxFrom,
      this.tnxBy,
      this.remark,
      this.tnxTo,
      this.tnxType,
      this.serviceCharge,
      this.tnxNumber,
      this.invoiceImageUrl,
      this.tnxTime);

  factory TransactionRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionRemoteModelToJson(this);
}

@JsonSerializable()
class TransactionByRemoteModel {
  final String transferredThrough;
  final String accountNumber;

  TransactionByRemoteModel(this.transferredThrough, this.accountNumber);

  factory TransactionByRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionByRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionByRemoteModelToJson(this);
}
