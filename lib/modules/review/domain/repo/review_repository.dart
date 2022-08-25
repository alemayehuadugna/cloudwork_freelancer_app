import 'package:dartz/dartz.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_core/error/failures.dart';
import '../entities/review.dart';

abstract class ReviewRepository {
  Future<Either<Failure, PaginatedQueryResult<List<Review>>>> listReview(
      {pagination, filter, sort});
  Future<Either<Failure, void>> giveReview(Review review);
}
