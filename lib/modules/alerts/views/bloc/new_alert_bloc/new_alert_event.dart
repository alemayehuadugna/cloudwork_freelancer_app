part of 'new_alert_bloc.dart';

abstract class NewAlertEvent extends Equatable {
  const NewAlertEvent();

  @override
  List<Object> get props => [];
}

class NotifyNewAlertEvent extends NewAlertEvent {
  final Alert alert;

  const NotifyNewAlertEvent(this.alert);

  @override
  List<Object> get props => [alert];
}
