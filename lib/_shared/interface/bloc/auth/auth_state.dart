part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final BasicUser user;

  const Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class Unverified extends AuthState {
  final BasicUser user;

  const Unverified({required this.user});

  @override
  List<Object> get props => [user];
}

class InCompleteProfile extends AuthState {
  final BasicUser user;

  const InCompleteProfile({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}
