import 'package:CloudWork_Freelancer/modules/chat/domain/entities/conversation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_conversation_state.dart';

class SelectedConversationCubit extends Cubit<SelectedConversationState> {
  SelectedConversationCubit() : super(SelectedConversationInitial());

  void selectConversation(Conversation conversation) {
    emit(SelectedConversationSuccess(conversation));
  }
}
