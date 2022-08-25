part of 'give_review_bloc.dart';

abstract class GiveReviewState extends Equatable {
  const GiveReviewState();

  @override
  List<Object> get props => [];
}

class GiveReviewInitial extends GiveReviewState {}

class GiveReviewLoading extends GiveReviewState {}

class GiveReviewSuccess extends GiveReviewState {}

class GiveReviewError extends GiveReviewState {
  final String message;

  const GiveReviewError(this.message);

  @override
  List<Object> get props => [message];
}
