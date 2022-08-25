import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../job/common/params.dart';
import '../../../job/domain/entities/job.dart';

abstract class BidRepository {
  Future<Either<Failure, List<JobEntity>>> listBids(
      PaginationParams params);
}
