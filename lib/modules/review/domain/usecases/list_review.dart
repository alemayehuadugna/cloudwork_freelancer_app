import 'package:dartz/dartz.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/review.dart';
import '../repo/review_repository.dart';

class ListReviewUseCase
    implements UseCase<PaginatedQueryResult<List<Review>>, QueryParams> {
  final ReviewRepository repository;

  ListReviewUseCase({required this.repository});
  @override
  Future<Either<Failure, PaginatedQueryResult<List<Review>>>> call(
      QueryParams params) async {
    return await repository.listReview(
        pagination: params.pagination,
        sort: params.sort,
        filter: params.filter);
  }
}
