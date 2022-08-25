import 'package:dio/dio.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_shared/data/mappers/result_page_mapper.dart';
import '../../domain/entities/review.dart';
import '../mapper/review_mapper.dart';

abstract class ReviewRemoteDataSource {
  Future<PaginatedQueryResult<List<Review>>> getReviews(
      {pagination, filter, sort});

  Future<void> writeReview(data);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final Dio dio;

  ReviewRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaginatedQueryResult<List<Review>>> getReviews(
      {pagination, filter, sort}) async {
    print("filter: ${filter['reviewedId']}");
    String path = '/users/${filter['reviewedId']}/reviews';
    final response = await dio.get(path);
    return PaginatedQueryResult(
      data: ReviewMapper.fromJson(response.data['data']),
      page: ResultPageMapper.fromJson(response.data['page']),
    );
  }

  @override
  Future<void> writeReview(data) async {
    String path = '/reviews';
    await dio.post(path, data: data);
    return;
  }
}
