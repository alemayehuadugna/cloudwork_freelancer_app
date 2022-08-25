part of 'alert_bloc.dart';

abstract class AlertEvent extends Equatable {
  const AlertEvent();

  @override
  List<Object> get props => [];
}

class SendAlertEvent extends AlertEvent {}

class ListAlertEvent extends AlertEvent {
  final List<Alert> list;

  const ListAlertEvent(this.list);

  @override
  List<Object> get props => [list];
}
