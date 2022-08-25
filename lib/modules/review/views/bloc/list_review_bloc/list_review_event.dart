part of 'list_review_bloc.dart';

abstract class ListReviewEvent extends Equatable {
  const ListReviewEvent();

  @override
  List<Object> get props => [];
}

class QueryReviewListEvent extends ListReviewEvent {
  final dynamic pagination;
  final dynamic filter;
  final dynamic sort;

  const QueryReviewListEvent({this.pagination, this.filter, this.sort});

  @override
  List<Object> get props => [pagination, filter, sort];
}
