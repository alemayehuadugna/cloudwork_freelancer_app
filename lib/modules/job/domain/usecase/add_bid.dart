
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../repo/job_repository.dart';

class AddProposalUseCase implements UseCase<String, AddProposalParams> {
  final JobRepository repository;

  AddProposalUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(AddProposalParams params) async {
    return await repository.addProposal(params);
  }
}

class AddProposalParams extends Equatable {
  final String jobId;
  final String? freelancerId;
  final double budget;
  final int hours;
  final String coverLetter;
  final bool isTermsAndConditionAgreed;

  AddProposalParams(this.jobId, this.freelancerId, this.budget, this.hours, this.coverLetter, this.isTermsAndConditionAgreed);

  @override
  List<Object?> get props =>
      [jobId, freelancerId, budget, hours, coverLetter, isTermsAndConditionAgreed];
}
