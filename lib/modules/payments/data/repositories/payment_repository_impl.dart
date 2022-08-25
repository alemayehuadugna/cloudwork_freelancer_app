import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_core/error/failures.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repo/payment_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  final PaymentLocalDataSource localDataSource;

  PaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> deposit(
      double amount, TransactionBy tnxBy, String tnxNumber) async {
    try {
      await remoteDataSource.deposit(amount, tnxBy, tnxNumber);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, Wallet>> getWallet() async {
    try {
      final wallet = await remoteDataSource.getWallet();
      return Right(wallet);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, PaginatedQueryResult<List<Transaction>>>>
      listTransactions({pagination, filter, sort}) async {
    try {
      final transactions = await remoteDataSource.getTransactions(
          pagination: pagination, filter: filter, sort: sort);
      return Right(transactions);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, void>> withdraw(
      double amount, TransactionBy tnxBy) async {
    try {
      await remoteDataSource.withdraw(amount, tnxBy);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, String>> depositWithChapa(double amount) async {
    try {
      String checkoutUrl = await remoteDataSource.depositWithChapa(amount);
      return Right(checkoutUrl);
    } catch (err) {
      print("depositWithChapa: Error $err");
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure("unknown error"));
    }
  }
}
