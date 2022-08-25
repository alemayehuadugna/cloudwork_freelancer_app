part of 'selected_conversation_cubit.dart';

abstract class SelectedConversationState extends Equatable {
  const SelectedConversationState();

  @override
  List<Object> get props => [];
}

class SelectedConversationInitial extends SelectedConversationState {}

class SelectedConversationSuccess extends SelectedConversationState {
  final Conversation conversation;

  const SelectedConversationSuccess(
    this.conversation,
  );

  @override
  List<Object> get props => [conversation];
}
