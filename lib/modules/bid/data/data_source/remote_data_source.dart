import 'package:CloudWork_Freelancer/modules/bid/data/mappers/bid_mapper.dart';
import 'package:CloudWork_Freelancer/modules/bid/data/models/json/bid_remote_model.dart';
import 'package:dio/dio.dart';

import '../../../job/common/params.dart';
import '../../../job/data/mappers/job_mapper.dart';
import '../../../job/data/models/json/job_remote_model.dart';

abstract class BidRemoteDataSource {
  Future<List<JobRemoteModel>> listBids(PaginationParams params);
}

class BidRemoteDataSourceImpl implements BidRemoteDataSource {
  final Dio dio;

  BidRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<JobRemoteModel>> listBids(PaginationParams params) async {
    String path = "/list/bids/freelancer";
    var pagination = {'page': params.pageKey, 'limit': params.pageSize};
    final response = await dio.patch(path, queryParameters: pagination);
    final data = <JobRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(JobMapper.fromJson(item));
    });
    return data;
  }
}
