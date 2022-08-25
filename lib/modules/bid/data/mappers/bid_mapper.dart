// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:CloudWork_Freelancer/modules/bid/data/models/json/bid_remote_model.dart';
import 'package:CloudWork_Freelancer/modules/bid/domain/entities/bid.dart';

class BidMapper {
  static BidListRemoteModel toModel(BidListEntity job) {
    List<ClientRemoteModel> clients = [];
    if (job.clientId != null) {
      clients.addAll(job.clientId!.map(
        (e) => ClientRemoteModel(
          e.clientId,
          e.firstName,
          e.lastName,
          e.profilePicture,
          e.completedJobs, 
          e.createdAt
        ),
      ));
    }

    BidListRemoteModel bidRemoteModel = BidListRemoteModel(
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
    );

    return bidRemoteModel;
  }

  static List<BidListEntity> toRemoteEntity(List<BidListRemoteModel> bidModel) {
    List<ClientEntity> clients = [];
    List<BidListEntity> bid = [];
    BidListEntity single;

    for (int i = 0; i < bidModel.length; i++) {
      if (bidModel[i].freelancerId != null) {
        clients.addAll(bidModel[i].clientId!.map(
              (e) => ClientEntity(
                e.clientId,
                e.firstName,
                e.lastName,
                e.profilePicture,
                e.completedJobs, 
                e.createdAt
              ),
            ));
      }
      single = BidListEntity(
        id: bidModel[i].id,
        clientId: bidModel[i].clientId == null ? null : clients,
        freelancerId: bidModel[i].freelancerId,
        title: bidModel[i].title,
        skills: bidModel[i].skills,
        budget: bidModel[i].budget,
        category: bidModel[i].category,
        proposals: bidModel[i].proposals,
        duration: bidModel[i].duration,
        expiry: bidModel[i].expiry,
        language: bidModel[i].language,
        progress: bidModel[i].progress!,
        createdAt: bidModel[i].createdAt,
      );

      bid.add(single);
      clients = [];
    }

    return bid;
  }

  

  
  static BidListRemoteModel fromJson(Map<String, dynamic> json) {
    var bid;
    List<ClientRemoteModel> clients = [];

    try {
      bid = BidListRemoteModel.fromJson(json);

      if (bid.clientId != null) {
        bid.clientId.forEach((e) {
          clients.add(
            ClientRemoteModel(
              e.clientId,
              e.firstName,
              e.lastName,
              e.profilePicture,
              e.completedJobs,
              e.createdAt
            ),
          );
        });
      }
    } catch (e) {
      print("in job mapper -->");
      print(e);
    }

    final BidListRemoteModel bidRemoteModel = BidListRemoteModel(
      bid.id,
      bid.clientId == null ? null : clients,
      bid.freelancerId,
      bid.title,
      bid.skills,
      bid.budget,
      bid.category,
      bid.proposals,
      bid.duration,
      bid.expiry,
      bid.language,
      bid.progress,
      bid.createdAt,
    );

    return bidRemoteModel;
  }
}
