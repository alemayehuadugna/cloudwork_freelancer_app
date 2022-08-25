part of 'forget_password_bloc.dart';

abstract class ForgetPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgetPasswordRequested extends ForgetPasswordEvent {
  final String email;

  ForgetPasswordRequested(this.email);

  @override
  List<Object> get props => [email];
}
