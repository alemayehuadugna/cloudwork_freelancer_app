import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../_core/error/failures.dart';
import '../../common/params.dart';
import '../../domain/entities/job.dart';
import '../../domain/repo/job_repository.dart';
import '../../domain/usecase/add_bid.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../mappers/job_mapper.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remoteDataSource;
  final JobLocalDataSource localDataSource;

  JobRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<JobEntity>>> listJobs(
      PaginationParams params) async {
    try {
      final remoteJob = await remoteDataSource.listJobs(params);

      return Right(JobMapper.toRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }

      return Left(ServerFailure('unknown server error'));
      // }
    }
  }

  @override
  Future<Either<Failure, JobDetailEntity>> getJob(JobParams params) async {
    try {
      final remoteJob = await remoteDataSource.getJob(params);
      return Right(JobMapper.jobDetailToRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, String>> addProposal(AddProposalParams params) async {
    try {
      final remoteJob = await remoteDataSource.addProposal(params);
      return Right(remoteJob);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> ongoingJobs(
      PaginationParams params) async {
    try {
      final remoteJob = await remoteDataSource.ongoingJob(params);
      return Right(JobMapper.toRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> completedJobs(
      PaginationParams params) async {
    try {
      final remoteJob = await remoteDataSource.completedJob(params);
      return Right(JobMapper.toRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> cancelJobs(
      PaginationParams params) async {
    try {
      final remoteJob = await remoteDataSource.canceledJob(params);
      return Right(JobMapper.toRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }
}
