part of 'list_job_bloc.dart';


abstract class ListJobEvent extends Equatable {
  const ListJobEvent();

  @override
  List<Object> get props => [];
}

class ListJobInSubmitted extends ListJobEvent {
  final int pageSize;
  final int pageKey; 

  const ListJobInSubmitted({
    required this.pageSize, 
    required this.pageKey, 
  });
}

class ListBidInSubmitted extends ListJobEvent {
  final int pageSize;
  final int pageKey; 
  final String freelancerId;

  const ListBidInSubmitted({
    required this.pageSize, 
    required this.pageKey, 
    required this.freelancerId
  });
}

class ListOngoingJobInSubmitted extends ListJobEvent {
  final int pageSize;
  final int pageKey; 
  final String freelancerId;

  const ListOngoingJobInSubmitted({
    required this.pageSize, 
    required this.pageKey, 
    required this.freelancerId
  });
}

class ListCompletedJobInSubmitted extends ListJobEvent {
  final int pageSize;
  final int pageKey; 
  final String freelancerId;

  const ListCompletedJobInSubmitted({
    required this.pageSize, 
    required this.pageKey, 
    required this.freelancerId
  });
}

class ListCanceledJobInSubmitted extends ListJobEvent {
  final int pageSize;
  final int pageKey; 
  final String freelancerId;

  const ListCanceledJobInSubmitted({
    required this.pageSize, 
    required this.pageKey, 
    required this.freelancerId
  });
}