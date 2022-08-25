import 'package:hive/hive.dart';

import '../../../../_core/error/exceptions.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/wallet.dart';
import '../mappers/transaction_mapper.dart';
import '../mappers/wallet_mapper.dart';
import '../models/hive/transaction_local_model.dart';
import '../models/hive/wallet_local_model.dart';

const transactionBox = 'transactions';
const transactionsKey = 'user-transactions';
const walletBox = 'wallet';
const walletKey = 'user-wallet';

abstract class PaymentLocalDataSource {
  Future<void> cacheWallet(WalletLocalModel walletToCache);

  Future<Wallet> getCachedWallet();

  Future<void> cacheTransactions(
      List<TransactionLocalModel> transactionsToCache);

  Future<List<Transaction>> getCachedTransactions();
}

class PaymentLocalDataSourceImpl implements PaymentLocalDataSource {
  final HiveInterface hive;

  PaymentLocalDataSourceImpl({required this.hive});

  @override
  Future<void> cacheTransactions(
      List<TransactionLocalModel> transactionsToCache) async {
    try {
      var transactionStore =
          await hive.openLazyBox<List<TransactionLocalModel>>(transactionBox);
      transactionStore.put(transactionsKey, transactionsToCache);
    } catch (err) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheWallet(WalletLocalModel walletToCache) async {
    try {
      var walletStore = await hive.openLazyBox<WalletLocalModel>(walletBox);
      walletStore.put(walletKey, walletToCache);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<Transaction>> getCachedTransactions() async {
    final transactionStore =
        await hive.openLazyBox<List<TransactionLocalModel>>(transactionBox);

    final cachedTransactions =
        await transactionStore.get(transactionsKey, defaultValue: []);
    if (cachedTransactions != null) {
      return cachedTransactions
          .map((e) => TransactionMapper.toEntity(e))
          .toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<Wallet> getCachedWallet() async {
    final walletStore = await hive.openLazyBox<WalletLocalModel>(walletBox);
    final cachedWallet = await walletStore.get(walletKey);
    if (cachedWallet != null) {
      return WalletMapper.toEntity(cachedWallet);
    } else {
      throw CacheException();
    }
  }
}
