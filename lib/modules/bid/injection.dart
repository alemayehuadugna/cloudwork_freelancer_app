// import 'package:CloudWork_Freelancer/modules/bid/data/data_source/remote_data_source.dart';
// import 'package:CloudWork_Freelancer/modules/bid/data/repositories/bid_repository_impl.dart';
// import 'package:CloudWork_Freelancer/modules/bid/domain/repo/bid_repository.dart';
// import 'package:CloudWork_Freelancer/modules/bid/domain/usecase/list_bid.dart';
// import 'package:get_it/get_it.dart';

// void injectBids(GetIt container) {
  
//   //! Data Source Injection
//   container.registerLazySingleton<BidRemoteDataSource>(
//       () => BidRemoteDataSourceImpl(dio: container()));
//   container.registerLazySingleton<BidRepository>(
//     () => BidListRepositoryImpl(remoteDataSource: container()),
//   );

//   //! Use Case Injection
//   container.registerLazySingleton(() => ListBid(repository: container()));
//   }
