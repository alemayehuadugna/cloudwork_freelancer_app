part of 'new_alert_bloc.dart';

abstract class NewAlertState extends Equatable {
  const NewAlertState();

  @override
  List<Object> get props => [];
}

class NewAlertInitial extends NewAlertState {}

class NewAlertLoaded extends NewAlertState {
  final Alert alert;

  const NewAlertLoaded(this.alert);

  @override
  List<Object> get props => [alert];
}
