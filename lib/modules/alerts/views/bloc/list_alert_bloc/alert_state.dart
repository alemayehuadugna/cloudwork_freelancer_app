part of 'alert_bloc.dart';

abstract class AlertState extends Equatable {
  const AlertState();

  @override
  List<Object> get props => [];
}

class AlertInitial extends AlertState {}

class AlertLoading extends AlertState {}

class AlertLoaded extends AlertState {
  final List<Alert> alertList;

  const AlertLoaded(this.alertList);

  @override
  List<Object> get props => [alertList];
}

class AlertError extends AlertState {}
