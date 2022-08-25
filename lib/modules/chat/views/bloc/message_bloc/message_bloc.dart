import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/usecase.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/list_message.dart';
import '../../../domain/usecases/load_messages.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final ListMessageUseCase listMessage;
  final LoadMessagesUseCase loadMessage;
  late StreamSubscription<Map<String, List<Message>>> messageSubscription;

  MessageBloc({
    required this.listMessage,
    required this.loadMessage,
  }) : super(MessageInitial()) {
    on<ListMessageEvent>(_listMessageEvent);
    on<LoadMessageEvent>(_loadMessagesEvent);
    listMessage(NoParams()).then((value) => value.fold(
          (_) => null,
          (messageStream) {
            messageSubscription = messageStream.listen(
              (prop) => add(ListMessageEvent(prop)),
            );
            // messageSubscription.resume();
          },
        ));
  }

  // @override
  // Future<void> close() {
  //   messageSubscription.cancel();
  //   listMessage.repository.dispose();
  //   return super.close();
  // }

  void _listMessageEvent(
    ListMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    emit(MessageLoading());
    emit(MessageLoaded(event.mapList));
  }

  void _loadMessagesEvent(
    LoadMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    await loadMessage(LoadMessagesParams(
        event.conversationId, event.pagination, event.filter));
  }
}
