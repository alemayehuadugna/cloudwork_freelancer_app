import 'package:hive/hive.dart';

import 'transaction_local_model.dart';
import 'wallet_local_model.dart';

class PaymentAdapter {
  static void registerPaymentAdapter() {
    Hive.registerAdapter<WalletLocalModel>(WalletLocalModelAdapter());
    Hive.registerAdapter<TransactionLocalModel>(TransactionLocalModelAdapter());
    Hive.registerAdapter<TransactionByLocalModel>(
        TransactionByLocalModelAdapter());
  }
}
