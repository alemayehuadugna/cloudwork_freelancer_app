import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../../_core/error/exceptions.dart';
import '../models/hive/job_hive_model.dart';
import '../models/json/job_remote_model.dart';

abstract class JobLocalDataSource {
  Future<void> cacheJobs(List<JobRemoteModel> jobToCache);
  Future<List<JobHiveModel>> listCachedJobs();
  Future<void> cacheJob(JobRemoteModel jobToCache);
  Future<JobHiveModel> getJob();
}

class JobLocalDataSourceImpl implements JobLocalDataSource {
  final HiveInterface hive;

  JobLocalDataSourceImpl({required this.hive});

  @override
  Future<void> cacheJobs(List<JobRemoteModel> jobToCache) async {
    try {
      var data = [];
      for (var element in jobToCache) {
        data.add(json.encode(element.toJson()));
      }
      var jobBox = await hive.openBox('job');
      jobBox.put("cachedJob", data);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<JobHiveModel>> listCachedJobs() async {
    final jobBox = await hive.openBox('job');
    final cachedData = jobBox.get("cachedJob");
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheJob(JobRemoteModel jobToCache) async {
    try {
      var jobBox = await hive.openBox('jobDetail');
      jobBox.put("cachedDetailJob", jobToCache);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<JobHiveModel> getJob() async {
    final jobBox = await hive.openBox('job');
    final cachedData = jobBox.get("cachedDetailJob");
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }
}
