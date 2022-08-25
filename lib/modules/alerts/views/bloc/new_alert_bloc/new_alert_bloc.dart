import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/usecase.dart';
import '../../../domain/entity/alert.dart';
import '../../../domain/usecases/notify_new_alert.dart';

part 'new_alert_event.dart';
part 'new_alert_state.dart';

class NewAlertBloc extends Bloc<NewAlertEvent, NewAlertState> {
  final NotifyNewAlertUseCase notifyNewAlert;
  NewAlertBloc({required this.notifyNewAlert}) : super(NewAlertInitial()) {
    on<NotifyNewAlertEvent>(_notifyNewAlertEvent);
    notifyNewAlert(NoParams()).then((value) => value.fold(
          (error) {
            print("notifyNewEvent-bloc-Error: $error");
          },
          (newAlertStream) {
            newAlertStream.listen((alert) {
              add(NotifyNewAlertEvent(alert));
            });
          },
        ));
  }

  void _notifyNewAlertEvent(
    NotifyNewAlertEvent event,
    Emitter<NewAlertState> emit,
  ) {
    emit(NewAlertInitial());
    emit(NewAlertLoaded(event.alert));
  }
}
