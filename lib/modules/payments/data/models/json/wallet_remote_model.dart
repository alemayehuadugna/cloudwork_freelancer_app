import 'package:json_annotation/json_annotation.dart';

part 'wallet_remote_model.g.dart';

@JsonSerializable()
class WalletRemoteModel {
  @JsonKey(name: 'balance')
  final double balance;
  @JsonKey(name: 'inTransaction')
  final double inTransaction;
  @JsonKey(name: 'invested')
  final double inInvestment;

  WalletRemoteModel(this.balance, this.inTransaction, this.inInvestment);

  factory WalletRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$WalletRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletRemoteModelToJson(this);
}
