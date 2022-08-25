part of 'get_job_bloc.dart';

abstract class JobDetailState extends Equatable {
  const JobDetailState();

  @override
  List<Object> get props => [];
}

class JobDetailInitial extends JobDetailState {}

class JobDetailLoading extends JobDetailState {}

class JobDetailLoaded extends JobDetailState {
  final JobDetailEntity job;

  const JobDetailLoaded({required this.job});
}

class ErrorLoadingJobDetail extends JobDetailState {
  final String message;

  const ErrorLoadingJobDetail({required this.message});
}

class AddProposalLoading extends JobDetailState {}

class AddProposalLoaded extends JobDetailState {}

class ErrorLoadingAddProposal extends JobDetailState {
  final String message;

  const ErrorLoadingAddProposal({required this.message});
}


