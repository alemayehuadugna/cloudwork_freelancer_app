part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class ListMessageEvent extends MessageEvent {
  final Map<String, List<Message>> mapList;

  const ListMessageEvent(this.mapList);

  @override
  List<Object> get props => [mapList];
}

// class SendMessageEvent extends MessageEvent {
//   final String conversationId;
//   final String content;

//   const SendMessageEvent(
//     this.conversationId,
//     this.content,
//   );

//   @override
//   List<Object> get props => [conversationId, content];
// }

class LoadMessageEvent extends MessageEvent {
  final String conversationId;
  final dynamic pagination;
  final dynamic filter;

  const LoadMessageEvent(this.conversationId, this.pagination, this.filter);

  @override
  List<Object> get props => [conversationId, pagination, filter];
}
