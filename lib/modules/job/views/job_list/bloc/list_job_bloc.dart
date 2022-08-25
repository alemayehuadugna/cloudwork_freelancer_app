import 'package:CloudWork_Freelancer/_core/error/failures.dart';
import 'package:CloudWork_Freelancer/modules/bid/domain/usecase/list_bid.dart';
import 'package:CloudWork_Freelancer/modules/job/common/pagination.dart';
import 'package:CloudWork_Freelancer/modules/job/common/params.dart';
import 'package:CloudWork_Freelancer/modules/job/domain/entities/job.dart';
import 'package:CloudWork_Freelancer/modules/job/domain/usecase/cancelledJobs.dart';
import 'package:CloudWork_Freelancer/modules/job/domain/usecase/completedJobs.dart';
import 'package:CloudWork_Freelancer/modules/job/domain/usecase/list_job.dart';
import 'package:CloudWork_Freelancer/modules/job/domain/usecase/ongoing_job.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bid/domain/entities/bid.dart';

part 'list_job_event.dart';
part 'list_job_state.dart';

class ListJobBloc extends Bloc<ListJobEvent, ListJobState> {
  final ListJob _listJob;
  final OngoingJob _ongoingJob;
  final CompletedJob _completedJob;
  final CanceledJob _canceledJob;
  final ListBid _listBid;

  ListJobBloc({
    required ListJob listJob,
    required OngoingJob ongoingJob,
    required ListBid listBid,
    required CompletedJob completedJob,
    required CanceledJob canceledJob,
  })  : _listJob = listJob,
        _listBid = listBid,
        _ongoingJob = ongoingJob,
        _completedJob = completedJob,
        _canceledJob = canceledJob,
        super(ListJobInitial()) {
    on<ListJobInSubmitted>(_listJobInSubmitted);
    on<ListBidInSubmitted>(_listBidInSubmitted);
    on<ListOngoingJobInSubmitted>(_listOngoingJobInSubmitted);
    on<ListCompletedJobInSubmitted>(_listCompletedJobInSubmitted);
    on<ListCanceledJobInSubmitted>(_listCanceledJobInSubmitted);
  }

  Future<void> _listJobInSubmitted(
      ListJobInSubmitted event, Emitter<ListJobState> emit) async {
    emit(ListJobLoading());
    final result =
        await _listJob(PaginationParams(event.pageKey, event.pageSize, ''));

    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          return ErrorLoadingListJob(message: error.message);
        }
        return const ErrorLoadingListJob(message: 'Unknown Error');
      }, (jobs) {
        return ListJobLoaded(job: jobs);
      }),
    );
  }

  Future<void> _listBidInSubmitted(
      ListBidInSubmitted event, Emitter<ListJobState> emit) async {
    emit(ListBidLoading());
    final result = await _listBid(
        PaginationParams(event.pageKey, event.pageSize, event.freelancerId));

    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          pagingController.appendLastPage([]);
          if (pagingController.itemList != null) {
            pagingController.itemList!.clear();
          }
          return ErrorLoadingListBid(message: error.message);
        }
        return const ErrorLoadingListBid(message: 'Unknown Error');
      }, (job) => ListBidLoaded(job: job)),
    );
  }

  Future<void> _listOngoingJobInSubmitted(
      ListOngoingJobInSubmitted event, Emitter<ListJobState> emit) async {
    if (state is! ListOngoingJobLoading) {
      emit(ListOngoingJobLoading());
    }
    final result = await _ongoingJob(
        PaginationParams(event.pageKey, event.pageSize, event.freelancerId));

    emit(
      // result.fold(
      //     (failure) => const ErrorLoadingListOngoingJob(
      //         message: "Error Loading Ongoing Job List"), (ongoingJob) {
      //   return ListOngoingJobLoaded(ongoingJob: ongoingJob);
      // }),

      result.fold((error) {
        if (error is ServerFailure) {
          print("ongoing error");
          pagingController.itemList!.clear();

          return ErrorLoadingListOngoingJob(message: error.message);
        }
        return const ErrorLoadingListOngoingJob(message: 'Unknown Error');
      }, (ongoingJob) => ListOngoingJobLoaded(ongoingJob: ongoingJob)),
    );
  }

  Future<void> _listCompletedJobInSubmitted(
      ListCompletedJobInSubmitted event, Emitter<ListJobState> emit) async {
    if (state is! ListCompletedJobLoading) {
      emit(ListCompletedJobLoading());
    }
    final result = await _completedJob(
        PaginationParams(event.pageKey, event.pageSize, event.freelancerId));

    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          pagingController.itemList!.clear();

          return ErrorLoadingListCompletedJob(message: error.message);
        }
        return const ErrorLoadingListCompletedJob(message: 'Unknown Error');
      }, (completedJob) => ListCompletedJobLoaded(completedJob: completedJob)),
    );
  }

  Future<void> _listCanceledJobInSubmitted(
      ListCanceledJobInSubmitted event, Emitter<ListJobState> emit) async {
    if (state is! ListCanceledJobLoading) {
      emit(ListCanceledJobLoading());
    }
    final result = await _canceledJob(
        PaginationParams(event.pageKey, event.pageSize, event.freelancerId));

    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          pagingController.itemList!.clear();

          return ErrorLoadingListCanceledJob(message: error.message);
        }
        return const ErrorLoadingListCanceledJob(message: 'Unknown Error');
      }, (canceledJob) => ListCanceledJobLoaded(canceledJob: canceledJob)),
    );
  }
}
