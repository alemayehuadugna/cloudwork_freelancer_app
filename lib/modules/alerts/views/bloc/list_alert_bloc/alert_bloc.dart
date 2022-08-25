import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/usecase.dart';
import '../../../domain/entity/alert.dart';
import '../../../domain/usecases/list_alert.dart';
import '../../../domain/usecases/send_alert.dart';

part 'alert_event.dart';
part 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final ListAlertUseCase listAlert;
  final SendAlertUseCase sendAlert;
  AlertBloc({
    required this.listAlert,
    required this.sendAlert,
  }) : super(AlertInitial()) {
    on<ListAlertEvent>(_listAlertEvent);
    on<SendAlertEvent>(_sendAlertEvent);
    listAlert(NoParams()).then((value) => value.fold(
          (error) => null,
          (alertStream) {
            alertStream.listen((list) {
              add(ListAlertEvent(list));
            });
          },
        ));
  }

  void _sendAlertEvent(
    SendAlertEvent event,
    Emitter<AlertState> emit,
  ) async {
    await sendAlert(NoParams());
  }

  void _listAlertEvent(
    ListAlertEvent event,
    Emitter<AlertState> emit,
  ) {
    emit(AlertLoading());
    emit(AlertLoaded(event.list));
  }
}
