import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/cqrs.dart';
import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecase.dart';
import '../../../domain/entities/review.dart';
import '../../../domain/usecases/list_review.dart';

part 'list_review_event.dart';
part 'list_review_state.dart';

class ListReviewBloc extends Bloc<ListReviewEvent, ListReviewState> {
  final ListReviewUseCase listReviewUseCase;

  ListReviewBloc({required this.listReviewUseCase})
      : super(ListReviewInitial()) {
    on<QueryReviewListEvent>(_listReviewEvent);
  }

  void _listReviewEvent(
    QueryReviewListEvent event,
    Emitter<ListReviewState> emit,
  ) async {
    emit(ListReviewLoading());

    final result = await listReviewUseCase(
        QueryParams(event.pagination, event.filter, event.sort));

    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ListReviewError(error.message);
        }
        return const ListReviewError('Error Occurred Getting Reviews');
      },
      (reviews) => ListReviewLoaded(reviews),
    ));
  }
}
