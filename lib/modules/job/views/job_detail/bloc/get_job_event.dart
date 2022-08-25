part of 'get_job_bloc.dart';

abstract class JobDetailEvent extends Equatable {
  const JobDetailEvent();

  @override 
  List<Object> get props => []; 
}


class GetJobEvent extends JobDetailEvent {
  final String id;

  const GetJobEvent({required this.id});
}

class AddProposalEvent extends JobDetailEvent {
  final AddProposalParams payload;

  const AddProposalEvent({required this.payload});
}