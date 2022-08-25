part of 'give_review_bloc.dart';

abstract class GiveReviewEvent extends Equatable {
  const GiveReviewEvent();

  @override
  List<Object> get props => [];
}

class WriteReviewEvent extends GiveReviewEvent {
  final String jobId;
  final String reviewedId;
  final String reviewerId;
  final String title;
  final String comment;
  final double rate;

  const WriteReviewEvent(this.jobId, this.reviewedId, this.reviewerId,
      this.title, this.comment, this.rate);

  @override
  List<Object> get props =>
      [jobId, reviewedId, reviewerId, title, comment, rate];
}
