part of 'forget_password_bloc.dart';

abstract class ForgetPasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {}

class ForgetPasswordFailure extends ForgetPasswordState {
  final String error;

  ForgetPasswordFailure({required this.error});

  @override
  List<Object> get props => [error];
}
