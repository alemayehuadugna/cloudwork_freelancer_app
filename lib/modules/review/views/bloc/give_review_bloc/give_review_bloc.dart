import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../domain/usecases/give_review.dart';

part 'give_review_event.dart';
part 'give_review_state.dart';

class GiveReviewBloc extends Bloc<GiveReviewEvent, GiveReviewState> {
  final GiveReviewUseCase giveReviewUseCase;

  GiveReviewBloc({required this.giveReviewUseCase})
      : super(GiveReviewInitial()) {
    on<WriteReviewEvent>(_giveReviewEvent);
  }

  void _giveReviewEvent(
    WriteReviewEvent event,
    Emitter<GiveReviewState> emit,
  ) async {
    emit(GiveReviewLoading());
    final result = await giveReviewUseCase(GiveReviewParams(
        event.jobId,
        event.reviewedId,
        event.reviewerId,
        event.title,
        event.comment,
        event.rate));

    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return GiveReviewError(error.message);
        }
        return const GiveReviewError('Error Occurred while Saving Your Review');
      },
      (_) => GiveReviewSuccess(),
    ));
  }
}
