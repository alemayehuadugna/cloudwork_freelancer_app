import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../common/params.dart';
import '../entities/job.dart';
import '../usecase/add_bid.dart';
import '../usecase/get_job.dart';

abstract class JobRepository {
  Future<Either<Failure, List<JobEntity>>> listJobs(PaginationParams params);
  Future<Either<Failure, JobDetailEntity>> getJob(JobParams params);
  Future<Either<Failure, String>> addProposal(AddProposalParams params);
  Future<Either<Failure, List<JobEntity>>> ongoingJobs(PaginationParams params);
  Future<Either<Failure, List<JobEntity>>> completedJobs(
      PaginationParams params);
  Future<Either<Failure, List<JobEntity>>> cancelJobs(PaginationParams params);
}
