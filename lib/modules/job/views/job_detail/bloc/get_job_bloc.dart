import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/error/failures.dart';
import '../../../common/params.dart';
import '../../../domain/entities/job.dart';
import '../../../domain/usecase/add_bid.dart';
import '../../../domain/usecase/get_job.dart';

part 'get_job_event.dart';
part 'get_job_state.dart';

class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
  final GetJobUseCase _getJob;
  final AddProposalUseCase _addProposal;

  JobDetailBloc({required GetJobUseCase getJob, required AddProposalUseCase addProposal})
      : _getJob = getJob,
        _addProposal = addProposal,
        super(JobDetailInitial()) {
    on<GetJobEvent>(_getJobDetail);
    on<AddProposalEvent>(_addProposalEvent);
  }

  void _getJobDetail(GetJobEvent event, Emitter<JobDetailState> emit) async {
    emit(JobDetailLoading());
    final result = await _getJob(JobParams(id: event.id));
    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          return ErrorLoadingJobDetail(message: error.message);
        }
        return const ErrorLoadingJobDetail(message: 'Unknown Error');
      }, (job) => JobDetailLoaded(job: job)),
    );
  }

    void _addProposalEvent(
      AddProposalEvent event, Emitter<JobDetailState> emit) async {
    emit(AddProposalLoading());
    final result = await _addProposal(
      AddProposalParams(
        event.payload.jobId,
        event.payload.freelancerId,
        event.payload.budget,
        event.payload.hours,
        event.payload.coverLetter, 
        event.payload.isTermsAndConditionAgreed
      ),
    );
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorLoadingAddProposal(message: error.message);
        }
        return const ErrorLoadingAddProposal(message: 'Error While Adding Proposal');
      },
      (result) {
        return AddProposalLoaded();
      },
    ));
  }

}
