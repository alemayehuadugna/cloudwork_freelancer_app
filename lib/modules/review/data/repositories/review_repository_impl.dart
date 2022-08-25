import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_core/error/failures.dart';
import '../../domain/entities/review.dart';
import '../../domain/repo/review_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../mapper/review_mapper.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> giveReview(Review review) async {
    try {
      await remoteDataSource.writeReview(ReviewMapper.toJson(review));
      return const Right(null);
    } catch (e) {
      if (e is DioError) {
        return Left(ServerFailure(e.response!.data['message']));
      }
      return Left(ServerFailure('unidentified server error'));
    }
  }

  @override
  Future<Either<Failure, PaginatedQueryResult<List<Review>>>> listReview(
      {pagination, filter, sort}) async {
    try {
      final reviews = await remoteDataSource.getReviews(
          pagination: pagination, filter: filter, sort: sort);
      return Right(reviews);
    } catch (e) {
      if (e is DioError) {
        return Left(ServerFailure(e.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }
}
