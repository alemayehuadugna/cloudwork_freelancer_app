import 'package:dio/dio.dart';

import '../../common/params.dart';
import '../../domain/usecase/add_bid.dart';
import '../../domain/usecase/get_job.dart';
import '../mappers/job_mapper.dart';
import '../models/json/job_remote_model.dart';

abstract class JobRemoteDataSource {
  Future<List<JobRemoteModel>> listJobs(PaginationParams params);
  Future<JobDetailRemoteModel> getJob(JobParams params);
  Future<String> addProposal(AddProposalParams params);
  Future<List<JobRemoteModel>> ongoingJob(PaginationParams params);
  Future<List<JobRemoteModel>> completedJob(PaginationParams params);
  Future<List<JobRemoteModel>> canceledJob(PaginationParams params);
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final Dio dio;

  JobRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<JobRemoteModel>> listJobs(PaginationParams params) async {
    String path = "/jobs";
    var filter = const FilterRemoteModel('INACTIVE').toJson();
    var pagination = {
      'page': params.pageKey,
      'limit': params.pageSize,
      'filter': filter
    };
    final response = await dio.get(path, queryParameters: pagination);

    final data = <JobRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(JobMapper.fromJson(item));
    });
    return data;
  }

  @override
  Future<JobDetailRemoteModel> getJob(JobParams params) async {
    final response = await dio.get('/jobs/freelancer/detail/${params.id}');
    // print("response: ${response}");
    return JobMapper.detailFromJson(response.data['data']);
  }

  @override
  Future<String> addProposal(AddProposalParams params) async {
    final data = {
      'freelancerId': params.freelancerId,
      'budget': params.budget,
      'hours': params.hours,
      'coverLetter': params.coverLetter,
      'isTermsAndConditionAgreed': params.isTermsAndConditionAgreed
    };
    // print("data: $data");
    var response = await dio.patch('/add/bid/${params.jobId}', data: data);
    return "Success";
  }

  @override
  Future<List<JobRemoteModel>> ongoingJob(PaginationParams params) async {
    String path = "/jobs/freelancer";
    var filter = const FilterRemoteModel('ACTIVE').toJson();
    final response = await dio.get(path, queryParameters: {
      'page': params.pageKey,
      'limit': params.pageSize,
      'filter': filter
    });
    final data = <JobRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(JobMapper.fromJson(item));
    });
    return data;
  }

  @override
  Future<List<JobRemoteModel>> completedJob(PaginationParams params) async {
    String path = "/jobs/freelancer";
    var filter = const FilterRemoteModel('COMPLETED').toJson();
    final response = await dio.get(path, queryParameters: {
      'page': params.pageKey,
      'limit': params.pageSize,
      'filter': filter
    });
    final data = <JobRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(JobMapper.fromJson(item));
    });
    return data;
  }

  @override
  Future<List<JobRemoteModel>> canceledJob(PaginationParams params) async {
    String path = "/jobs/freelancer";
    var filter = const FilterRemoteModel('CANCELLED').toJson();

    final response = await dio.get(path, queryParameters: {
      'page': params.pageKey,
      'limit': params.pageSize,
      'filter': filter
    });
    final data = <JobRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(JobMapper.fromJson(item));
    });
    return data;
  }
}
