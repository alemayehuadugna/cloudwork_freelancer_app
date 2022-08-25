import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../_core/error/failures.dart';
import '../../../../../../_core/usecase.dart';
import '../../../domain/entities/detail_user.dart';
import '../../../domain/usecases/usecases.dart';

part 'detail_user_event.dart';
part 'detail_user_state.dart';

class DetailUserBloc extends Bloc<DetailUserEvent, DetailUserState> {
  final GetDetailUserUseCase _getDetailUser;

  DetailUserBloc({required GetDetailUserUseCase getDetailUser})
      : _getDetailUser = getDetailUser,
        super(DetailUserInitial()) {
    on<GetDetailUserEvent>(_getDetailUserEvent);
  }

  void _getDetailUserEvent(
    GetDetailUserEvent event,
    Emitter<DetailUserState> emit,
  ) async {
    emit(DetailUserLoading());
    final result = await _getDetailUser(NoParams());
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorLoadingDetailUser(error.message);
        } else if (error is CacheFailure) {
          return const ErrorLoadingDetailUser("Error when caching user data");
        }
        return const ErrorLoadingDetailUser('Error Loading Detail User');
      },
      (detailUser) => DetailUserLoaded(detailUser),
    ));
  }
}
