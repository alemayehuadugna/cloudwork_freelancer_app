import 'package:dio/dio.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_shared/data/mappers/result_page_mapper.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/wallet.dart';
import '../mappers/transaction_mapper.dart';
import '../mappers/wallet_mapper.dart';

abstract class PaymentRemoteDataSource {
  Future<Wallet> getWallet();

  Future<PaginatedQueryResult<List<Transaction>>> getTransactions(
      {pagination, filter, sort});

  Future<void> deposit(
    double amount,
    TransactionBy tnxBy,
    String tnxNumber,
  );

  Future<void> withdraw(
    double amount,
    TransactionBy tnxBy,
  );

  Future<String> depositWithChapa(double amount);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final Dio dio;

  PaymentRemoteDataSourceImpl({required this.dio});

  @override
  Future<void> deposit(
      double amount, TransactionBy tnxBy, String tnxNumber) async {
    String path = "/transactions/deposit";
    await dio.post(path, data: {
      "amount": amount,
      "tnxBy": {
        "transferredThrough": tnxBy.transferredThrough,
        "accountNumber": tnxBy.accountNumber,
      },
      "tnxNumber": tnxNumber,
    });
    return;
  }

  @override
  Future<void> withdraw(double amount, TransactionBy tnxBy) async {
    String path = "/transactions/withdraw";
    await dio.post(
      path,
      data: {
        "amount": amount,
        "tnxBy": {
          "transferredThrough": tnxBy.transferredThrough,
          "accountNumber": tnxBy.accountNumber,
        },
      },
    );
  }

  @override
  Future<PaginatedQueryResult<List<Transaction>>> getTransactions(
      {pagination, filter, sort}) async {
    String path = "/transactions";
    final response = await dio.get(path, queryParameters: pagination);
    // print("response: ${response.data}");
    return PaginatedQueryResult(
      data: TransactionMapper.fromJson(response.data["data"]),
      page: ResultPageMapper.fromJson(response.data['page']),
    );
  }

  @override
  Future<Wallet> getWallet() async {
    String path = "/wallet/me";
    final response = await dio.get(path);
    return WalletMapper.fromJson(response.data);
  }

  @override
  Future<String> depositWithChapa(double amount) async {
    String path = '/transactions/chapa/deposit';
    final response = await dio.post(path, data: {'amount': amount});
    
    print("Source: depositWithChapa: response ${response.data['data']['checkout_url']}");
    return response.data['data']['checkout_url'];
  }
}
