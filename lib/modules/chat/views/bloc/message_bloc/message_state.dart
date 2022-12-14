part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final Map<String, List<Message>> messageMapList;

  const MessageLoaded(this.messageMapList);

  @override
  List<Object> get props => [messageMapList];
}

class MessageError extends MessageState {}
