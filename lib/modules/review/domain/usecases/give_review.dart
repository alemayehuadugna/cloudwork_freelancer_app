import '../entities/review.dart';
import '../repo/review_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../_core/error/failures.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/usecase.dart';

class GiveReviewUseCase implements UseCase<void, GiveReviewParams> {
  final ReviewRepository repository;

  GiveReviewUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(GiveReviewParams params) async {
    Review review = Review(null,
        jobId: params.jobId,
        reviewerId: params.reviewerId,
        reviewedId: params.reviewedId,
        title: params.title,
        comment: params.comment,
        rate: params.rate,
        createdAt: null);
    return await repository.giveReview(review);
  }
}

class GiveReviewParams extends Equatable {
  final String jobId;
  final String reviewedId;
  final String reviewerId;
  final String title;
  final String comment;
  final double rate;

  const GiveReviewParams(
    this.jobId,
    this.reviewedId,
    this.reviewerId,
    this.title,
    this.comment,
    this.rate,
  );

  @override
  List<Object> get props => [
        jobId,
        reviewedId,
        reviewerId,
        title,
        comment,
        rate,
      ];
}
