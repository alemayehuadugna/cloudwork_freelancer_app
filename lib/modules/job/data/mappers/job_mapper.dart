// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import '../../domain/entities/job.dart';
import '../models/hive/job_hive_model.dart';
import '../models/json/job_remote_model.dart';

class JobMapper {
  static JobRemoteModel toModel(JobEntity job) {
    List<ClientRemoteModel> clients = [];
    if (job.clientId != null) {
      clients.addAll(job.clientId!.map(
        (e) => ClientRemoteModel(e.clientId, e.firstName, e.lastName,
            e.profilePicture, e.completedJobs, e.createdAt),
      ));
    }
    List<BidRemoteModel> bid = [];
    bid.addAll(job.bid.map(
      (e) => BidRemoteModel(
        e.freelancerId,
        e.budget,
        e.hours,
        e.coverLetter,
        e.isTermsAndConditionAgreed,
        e.createdAt,
        ProposalFreelancerRemoteModel(
            e.freelancer.firstName,
            e.freelancer.lastName,
            e.freelancer.profilePicture,
            e.freelancer.numberOfReviews),
      ),
    ));

    JobRemoteModel jobRemoteModel = JobRemoteModel(
        job.id,
        job.clientId == null ? null : clients,
        job.freelancerId,
        job.title,
        job.skills,
        job.budget,
        job.category,
        job.proposals,
        job.duration,
        job.expiry,
        job.language,
        job.progress,
        job.createdAt,
        bid);

    return jobRemoteModel;
  }

  static List<JobEntity> toRemoteEntity(List<JobRemoteModel> jobModel) {
    List<ClientEntity> clients = [];
    List<JobEntity> job = [];
    JobEntity single;

    List<BidEntity> bid = [];
    for (int i = 0; i < jobModel.length; i++) {
      bid.addAll(jobModel[i].bid.map(
            (e) => BidEntity(
              e.freelancerId,
              e.budget,
              e.hours,
              e.coverLetter,
              e.isTermsAndConditionAgreed,
              e.createdAt,
              ProposalFreelancerEntity(
                  e.freelancer.firstName,
                  e.freelancer.lastName,
                  e.freelancer.profilePicture,
                  e.freelancer.numberOfReviews),
            ),
          ));
    }

    for (int i = 0; i < jobModel.length; i++) {
      if (jobModel[i].freelancerId != null) {
        clients.addAll(jobModel[i].clientId!.map(
              (e) => ClientEntity(e.clientId, e.firstName, e.lastName,
                  e.profilePicture, e.completedJobs, e.createdAt),
            ));
      }
      single = JobEntity(
          id: jobModel[i].id,
          clientId: jobModel[i].clientId == null ? null : clients,
          freelancerId: jobModel[i].freelancerId,
          title: jobModel[i].title,
          skills: jobModel[i].skills,
          budget: jobModel[i].budget,
          category: jobModel[i].category,
          proposals: jobModel[i].proposals,
          duration: jobModel[i].duration,
          expiry: jobModel[i].expiry,
          language: jobModel[i].language,
          progress: jobModel[i].progress!,
          createdAt: jobModel[i].createdAt,
          bid: bid);

      job.add(single);
      clients = [];
    }

    return job;
  }

  // static JobEntity jobDetailToRemoteEntity(JobRemoteModel jobModel) {
  //   JobEntity job;
  //   return JobEntity(
  //     id: jobModel.id,
  //     title: jobModel.title,
  //     skills: jobModel.skills,
  //     budget: jobModel.budget,
  //     proposals: jobModel.proposals,
  //     expiry: jobModel.expiry,
  //     category: jobModel.category,
  //     progress: jobModel.progress,
  //     createdAt: jobModel.createdAt,
  //     experience: jobModel.experience,
  //   );
  // }

  static List<JobEntity> toLocalEntity(List<JobHiveModel> jobModel) {
    List<ClientEntity> clients = [];
    List<JobEntity> job = [];
    JobEntity single;
    for (int i = 0; i < jobModel.length; i++) {
      if (jobModel[i].clientId != null) {
        clients.addAll(jobModel[i].clientId!.map(
              (e) => ClientEntity(e.clientId, e.firstName, e.lastName,
                  e.profilePicture, e.completedJobs, e.createdAt),
            ));
      }

      List<BidEntity> bid = [];
      for (int i = 0; i < jobModel.length; i++) {
        bid.addAll(jobModel[i].bid.map(
              (e) => BidEntity(
                e.freelancerId,
                e.budget,
                e.hours,
                e.coverLetter,
                e.isTermsAndConditionAgreed,
                e.createdAt,
                ProposalFreelancerEntity(
                    e.freelancer.firstName,
                    e.freelancer.lastName,
                    e.freelancer.profilePicture,
                    e.freelancer.numberOfReviews),
              ),
            ));
      }

      single = JobEntity(
          id: jobModel[i].id,
          clientId: jobModel[i].clientId == null ? null : clients,
          freelancerId: jobModel[i].freelancerId,
          title: jobModel[i].title,
          skills: jobModel[i].skills,
          budget: jobModel[i].budget,
          category: jobModel[i].category,
          proposals: jobModel[i].proposals,
          duration: jobModel[i].duration,
          expiry: jobModel[i].expiry,
          language: jobModel[i].language,
          progress: jobModel[i].progress,
          createdAt: jobModel[i].createdAt,
          bid: bid);

      job.add(single);
      clients = [];
    }

    return job;
  }

  // static JobEntity jobDetailToLocalEntity(JobHiveModel jobModel) {
  //   return JobEntity(
  //       id: jobModel.id,
  //       title: jobModel.title,
  //       skills: jobModel.skills,
  //       budget: jobModel.budget,
  //       proposals: jobModel.proposals,
  //       expiry: jobModel.expiry,
  //       category: jobModel.category,
  //       progress: jobModel.progress,
  //       createdAt: jobModel.createdAt,
  //       experience: jobModel.experience);
  // }

  static JobRemoteModel fromJson(Map<String, dynamic> json) {
    var job;
    List<ClientRemoteModel> clients = [];
    List<BidRemoteModel> bid = [];

    try {
      job = JobRemoteModel.fromJson(json);
      if (job.clientId != null) {
        job.clientId.forEach((e) {
          clients.add(
            ClientRemoteModel(e.clientId, e.firstName, e.lastName,
                e.profilePicture, e.completedJobs, e.createdAt),
          );
        });
      }
      job.bid.forEach((e) {
        bid.add(BidRemoteModel(
          e.freelancerId,
          e.budget,
          e.hours,
          e.coverLetter,
          e.isTermsAndConditionAgreed,
          e.createdAt,
          ProposalFreelancerRemoteModel(
              e.freelancer.firstName,
              e.freelancer.lastName,
              e.freelancer.profilePicture,
              e.freelancer.numberOfReviews),
        ));
      });
    } catch (e) {
      print("in job mapper -->");
      print(e);
    }

    final JobRemoteModel jobRemoteModel = JobRemoteModel(
        job.id,
        job.clientId == null ? null : clients,
        job.freelancerId,
        job.title,
        job.skills,
        job.budget,
        job.category,
        job.proposals,
        job.duration,
        job.expiry,
        job.language,
        job.progress,
        job.createdAt,
        bid);

    return jobRemoteModel;
  }

  static JobDetailRemoteModel detailFromJson(Map<String, dynamic> json) {
    var job;
    List<BidRemoteModel> bids = [];
    List<ClientRemoteModel> clients = [];

    try {
      job = JobDetailRemoteModel.fromJson(json);
      job.bid.forEach((e) {
        bids.add(
          BidRemoteModel(
            e.freelancerId,
            e.budget,
            e.hours,
            e.coverLetter,
            e.isTermsAndConditionAgreed,
            e.createdAt,
            ProposalFreelancerRemoteModel(
                e.freelancer.firstName,
                e.freelancer.lastName,
                e.freelancer.profilePicture,
                e.freelancer.numberOfReviews),
          ),
        );
      });
      if (job.clientId != null) {
        job.clientId.forEach((e) {
          clients.add(
            ClientRemoteModel(e.clientId, e.firstName, e.lastName,
                e.profilePicture, e.completedJobs, e.createdAt),
          );
        });
      }
    } catch (e) {
      print("in job mapper -->");
      print(e);
    }

    final JobDetailRemoteModel jobDetailRemoteModel = JobDetailRemoteModel(
      job.id,
      job.clientId == null ? null : clients,
      job.freelancerId,
      job.title,
      job.skills,
      job.budget,
      job.duration,
      job.proposals,
      job.expiry,
      job.category,
      job.language,
      job.progress,
      job.startDate,
      job.links,
      job.description,
      job.files,
      job.createdAt,
      bids,
    );
    return jobDetailRemoteModel;
  }

  static JobDetailEntity jobDetailToRemoteEntity(
      JobDetailRemoteModel jobModel) {
    List<ClientEntity> clients = [];
    List<BidEntity> bids = [];

    if (jobModel.clientId != null) {
      clients.addAll(jobModel.clientId!.map(
        (e) => ClientEntity(e.clientId, e.firstName, e.lastName,
            e.profilePicture, e.completedJobs, e.createdAt),
      ));
    }

    bids.addAll(jobModel.bid.map(
      (e) => BidEntity(
        e.freelancerId,
        e.budget,
        e.hours,
        e.coverLetter,
        e.isTermsAndConditionAgreed,
        e.createdAt,
        ProposalFreelancerEntity(
          e.freelancer.firstName,
          e.freelancer.lastName,
          e.freelancer.profilePicture,
          e.freelancer.numberOfReviews,
        ),
      ),
    ));

    return JobDetailEntity(
      id: jobModel.id,
      clientId: jobModel.clientId == null ? null : clients,
      freelancerId: jobModel.freelancerId,
      title: jobModel.title,
      skills: jobModel.skills,
      budget: jobModel.budget,
      duration: jobModel.duration,
      proposals: jobModel.proposals,
      expiry: jobModel.expiry,
      category: jobModel.category,
      language: jobModel.language,
      progress: jobModel.progress,
      startDate: jobModel.startDate,
      links: jobModel.links,
      description: jobModel.description,
      files: jobModel.files,
      createdAt: jobModel.createdAt,
      bid: bids,
    );
  }
}
