
import 'package:get_it/get_it.dart';

import 'data/data_sources/local_data_source.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/payment_repository_impl.dart';
import 'domain/repo/payment_repository.dart';
import 'domain/usecases/deposit.dart';
import 'domain/usecases/deposit_chapa.dart';
import 'domain/usecases/get_wallet.dart';
import 'domain/usecases/list_transactions.dart';
import 'domain/usecases/withdraw.dart';
import 'views/bloc/transaction_bloc/transaction_bloc.dart';
import 'views/bloc/wallet_bloc/payment_bloc.dart';

void injectPayments(GetIt container) {
  //! Data Source Injection
  container.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(dio: container()),
  );
  container.registerLazySingleton<PaymentLocalDataSource>(
    () => PaymentLocalDataSourceImpl(hive: container()),
  );
  container.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      remoteDataSource: container(),
      localDataSource: container(),
    ),
  );

  //! Usecase Injection
  container.registerLazySingleton(() => DepositUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => WithdrawUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => ListTransactionsUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => GetWalletUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => DepositChapaUseCase(
        repository: container(),
      ));

  //! Bloc Injection
  container.registerFactory(() => PaymentBloc(
        depositUseCase: container(),
        withdrawUseCase: container(),
        getWalletUseCase: container(),
        depositChapaUseCase: container(),
      ));
  container.registerFactory(() => TransactionBloc(
        listTransactionsUseCase: container(),
      ));
}
