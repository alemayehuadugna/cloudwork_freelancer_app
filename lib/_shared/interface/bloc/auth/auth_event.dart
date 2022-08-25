part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

class UserLoggedIn extends AuthEvent {
  final BasicUser user;

  const UserLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class UserLoggedOut extends AuthEvent {}

class GetBasicUserEvent extends AuthEvent {
  const GetBasicUserEvent();

  @override
  List<Object> get props => [];
}
