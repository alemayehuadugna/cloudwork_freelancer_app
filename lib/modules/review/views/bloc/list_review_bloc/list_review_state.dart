part of 'list_review_bloc.dart';

abstract class ListReviewState extends Equatable {
  const ListReviewState();

  @override
  List<Object> get props => [];
}

class ListReviewInitial extends ListReviewState {}

class ListReviewLoading extends ListReviewState {}

class ListReviewLoaded extends ListReviewState {
  final PaginatedQueryResult<List<Review>> reviews;

  const ListReviewLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class ListReviewError extends ListReviewState {
  final String message;

  const ListReviewError(this.message);

  @override
  List<Object> get props => [message];
}
