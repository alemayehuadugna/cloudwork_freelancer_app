part of 'update_profile_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();
}

class UpdateProfileInitial extends UpdateProfileState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileLoading extends UpdateProfileState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileSuccess<T> extends UpdateProfileState {
  final T? data;

  const UpdateProfileSuccess({this.data});

  @override
  List<T?> get props => [data];
}

class ErrorUpdatingProfile extends UpdateProfileState {
  final String message;

  const ErrorUpdatingProfile(this.message);

  @override
  List<Object> get props => [message];
}
