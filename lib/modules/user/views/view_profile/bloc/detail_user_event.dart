part of 'detail_user_bloc.dart';

abstract class DetailUserEvent extends Equatable {
  const DetailUserEvent();

  @override
  List<Object> get props => [];
}

class GetDetailUserEvent extends DetailUserEvent {}
