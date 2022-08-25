import 'package:flutter/foundation.dart';

import '../../domain/entities/wallet.dart';
import '../models/hive/wallet_local_model.dart';
import '../models/json/wallet_remote_model.dart';

class WalletMapper {
  static WalletLocalModel toModel(Wallet wallet) {
    return WalletLocalModel(
        balance: wallet.balance,
        inTransaction: wallet.inTransaction,
        inInvestment: wallet.inInvestment);
  }

  static Wallet toEntity(WalletLocalModel localWallet) {
    return Wallet(
        balance: localWallet.balance,
        inTransaction: localWallet.inTransaction,
        inInvestment: localWallet.inInvestment);
  }

  static Wallet fromJson(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var wallet;
    try {
      wallet = WalletRemoteModel.fromJson(json);
    } catch (e) {
      if (kDebugMode) {
        print("In Wallet Mapper from Json: $e");
      }
    }
    return Wallet(
        balance: wallet.balance,
        inTransaction: wallet.inTransaction,
        inInvestment: wallet.inInvestment);
  }
}
