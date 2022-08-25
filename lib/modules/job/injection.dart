import 'package:CloudWork_Freelancer/modules/job/domain/usecase/completedJobs.dart';
import 'package:CloudWork_Freelancer/modules/job/views/job_detail/bloc/get_job_bloc.dart';
import 'package:CloudWork_Freelancer/modules/job/views/job_list/bloc/list_job_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bid/data/data_source/remote_data_source.dart';
import '../bid/data/repositories/bid_repository_impl.dart';
import '../bid/domain/repo/bid_repository.dart';
import '../bid/domain/usecase/list_bid.dart';
import 'data/data_source/local_data_source.dart';
import 'data/data_source/remote_data_source.dart';
import 'data/repositories/job_repository_impl.dart';
import 'domain/repo/job_repository.dart';
import 'domain/usecase/add_bid.dart';
import 'domain/usecase/cancelledJobs.dart';
import 'domain/usecase/get_job.dart';
import 'domain/usecase/list_job.dart';
import 'domain/usecase/ongoing_job.dart';

void injectJobs(GetIt container) {
  //! Bloc Injection
  container.registerFactory(
    () => ListJobBloc(
      listJob: container(),
      listBid: container(),
      ongoingJob: container(),
      completedJob: container(),
      canceledJob: container(),
    ),
  );
  container.registerFactory(
      () => JobDetailBloc(getJob: container(), addProposal: container()));

  //! Data Source Injection
  container.registerLazySingleton<JobRemoteDataSource>(
      () => JobRemoteDataSourceImpl(dio: container()));
  container.registerLazySingleton<JobLocalDataSource>(
      () => JobLocalDataSourceImpl(hive: container()));
  container.registerLazySingleton<JobRepository>(
    () => JobRepositoryImpl(
      remoteDataSource: container(),
      localDataSource: container(),
    ),
  );
  
  //bid
   container.registerLazySingleton<BidRemoteDataSource>(
      () => BidRemoteDataSourceImpl(dio: container()));
  container.registerLazySingleton<BidRepository>(
    () => BidListRepositoryImpl(remoteDataSource: container()),
  );

  //! Use Case Injection
  container.registerLazySingleton(() => ListJob(repository: container()));
  container.registerLazySingleton(() => OngoingJob(repository: container()));
  // container.registerLazySingleton(() => ListBid(repository: container()));
  container.registerLazySingleton(() => CompletedJob(repository: container()));
  container.registerLazySingleton(() => CanceledJob(repository: container()));
  container.registerLazySingleton(() => GetJobUseCase(repository: container()));
  container
      .registerLazySingleton(() => AddProposalUseCase(repository: container()));
  // bid
  container.registerLazySingleton(() => ListBid(repository: container()));
}
