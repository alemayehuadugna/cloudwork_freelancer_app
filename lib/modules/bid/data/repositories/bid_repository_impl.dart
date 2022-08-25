import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:CloudWork_Freelancer/modules/bid/data/data_source/remote_data_source.dart';
import 'package:CloudWork_Freelancer/modules/job/domain/entities/job.dart';
import 'package:dartz/dartz.dart';
import 'package:CloudWork_Freelancer/modules/bid/domain/entities/bid.dart';
import 'package:dio/dio.dart';

import '../../../job/common/params.dart';
import '../../../job/data/mappers/job_mapper.dart';
import '../../domain/repo/bid_repository.dart';
import '../mappers/bid_mapper.dart';

class BidListRepositoryImpl implements BidRepository {
  final BidRemoteDataSource remoteDataSource;

  BidListRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<JobEntity>>> listBids(
      PaginationParams params) async {
    try {
      final remoteJob = await remoteDataSource.listBids(params);
      return Right(JobMapper.toRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }
}
