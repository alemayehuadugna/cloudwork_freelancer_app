import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/usecase.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/usecases/list_conversation.dart';
import '../../../domain/usecases/send_message.dart';
import '../../../domain/usecases/start_conversation.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final StartConversationUseCase startConversation;
  final ListConversationUseCase listConversation;
  final SendMessageUseCase sendMessage;
  ConversationBloc({
    required this.startConversation,
    required this.listConversation,
    required this.sendMessage,
  }) : super(ConversationInitial()) {
    on<StartConversationEvent>(_startConversationEvent);
    on<ListConversationEvent>(_listConversationEvent);
    on<SendMessageEvent>(_sendMessageEvent);
    final result = listConversation(NoParams());
    result.then((value) => value.fold(
          (error) => null,
          (conversationStream) {
            conversationStream.listen(
              (status) => add(ListConversationEvent(status)),
            );
          },
        ));
  }

  void _listConversationEvent(
    ListConversationEvent event,
    Emitter<ConversationState> emit,
  ) async {
    emit(ConversationLoading());
    emit(ConversationLoaded(event.list));
  }

  void _sendMessageEvent(
    SendMessageEvent event,
    Emitter<ConversationState> emit,
  ) async {
    await sendMessage(
      SendMessageParams(event.conversationId, event.content),
    );
  }

  void _startConversationEvent(
    StartConversationEvent event,
    Emitter<ConversationState> emit,
  ) async {
    await startConversation(const StartConversationParams("", ""));
  }
}
