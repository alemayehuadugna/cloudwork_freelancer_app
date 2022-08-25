import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../bloc/conversation_bloc/conversation_bloc.dart';
import '../bloc/message_bloc/message_bloc.dart';
import '../bloc/selected_conversation/selected_conversation_cubit.dart';
import '../widgets/widgets.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var route = GoRouter.of(context).location;

    return SizedBox(
      height: MediaQuery.of(context).size.height - 56,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(
            flex: 2,
            child: _Conversation(),
          ),
          if (route != '/chat')
            const Expanded(
              flex: 4,
              child: Messages(),
            ),
          if (route == '/chat')
            const Expanded(
              flex: 4,
              child: SizedBox(),
            ),
        ],
      ),
    );
  }
}

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 56,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: const [
          Expanded(
            flex: 2,
            child: _Conversation(),
          ),
          Expanded(
            flex: 4,
            child: Messages(),
          ),
        ],
      ),
    );
  }
}

class ChatMobilePage extends StatelessWidget {
  const ChatMobilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Conversation();
  }
}

class MessageMobilePage extends StatelessWidget {
  const MessageMobilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: const Messages(),
    );
  }
}

class _Conversation extends StatelessWidget {
  const _Conversation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Card(
            elevation: 1,
            margin: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          splashRadius: 24,
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 0.5),
                if (state is ConversationLoaded)
                  SizedBox(
                    height: ResponsiveWrapper.of(context).isMobile
                        ? MediaQuery.of(context).size.height - 130 - 55
                        : MediaQuery.of(context).size.height - 130,
                    child: ListView.builder(
                      controller: ScrollController(),
                      shrinkWrap: true,
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        return ConversationTile(
                          conversation: state.conversations[index],
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Messages extends StatelessWidget {
  const Messages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? _messageField = TextEditingController();
    String conversationId = '';
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String currentUserId = '';
        if (state is Authenticated) {
          currentUserId = state.user.id;
        }
        return BlocBuilder<SelectedConversationCubit,
            SelectedConversationState>(
          builder: (context, state) {
            if (state is SelectedConversationSuccess) {
              conversationId = state.conversation.id;
              // print("selectedConversation: ${state.conversation.id}");
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    const MessageHeader(),
                    const Divider(height: 0.5),
                    Expanded(
                      child: BlocBuilder<MessageBloc, MessageState>(
                        builder: (context, state) {
                          if (state is MessageLoaded) {
                            var list =
                                state.messageMapList[conversationId] ?? [];
                            return SizedBox(
                                child: ListView.builder(
                              reverse: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return MessageTile(
                                  isSender:
                                      currentUserId == list[index].senderId,
                                  message: list[index].content,
                                  sentTime: list[index].sentAt,
                                );
                              },
                            ));
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: RawKeyboardListener(
                          focusNode: FocusNode(onKey: (node, event) {
                            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                              return KeyEventResult
                                  .handled; // prevent passing the event into the TextField
                            }
                            return KeyEventResult
                                .ignored; // pass the event to the TextField
                          }),
                          onKey: (event) {
                            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                              // Do something
                              // print("messageToSend: ${_messageField.text}");
                              if (_messageField.text.isNotEmpty) {
                                BlocProvider.of<ConversationBloc>(context).add(
                                  SendMessageEvent(
                                    conversationId,
                                    _messageField.text,
                                  ),
                                );
                                _messageField.text = '';
                              }
                            }
                          },
                          child: TextFormField(
                            textInputAction: TextInputAction.send,
                            controller: _messageField,
                            minLines: 1,
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.emoji_emotions),
                                ),
                              ),
                              // pre
                              suffixIcon: SizedBox(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 5,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.attach_file),
                                      splashRadius: 24,
                                    ),
                                    IconButton(
                                      iconSize: 30,
                                      onPressed: () {
                                        // print(
                                        //     "messageToSend: ${_messageField.text}");
                                        if (_messageField.text.isNotEmpty) {
                                          BlocProvider.of<ConversationBloc>(
                                                  context)
                                              .add(
                                            SendMessageEvent(
                                              conversationId,
                                              _messageField.text,
                                            ),
                                          );
                                          _messageField.text = '';
                                        }
                                      },
                                      icon: const Icon(Icons.send),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

