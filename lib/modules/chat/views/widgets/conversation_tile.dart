import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../domain/entities/conversation.dart';
import '../../router.dart';
import '../bloc/message_bloc/message_bloc.dart';
import '../bloc/selected_conversation/selected_conversation_cubit.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String currentUserId = '';
        String userName = '';
        String profilePicture = '';
        if (state is Authenticated) {
          currentUserId = state.user.id;
          for (var e in conversation.members) {
            if (e.userId != currentUserId) {
              userName = "${e.user!.firstName} ${e.user!.lastName}";
              profilePicture = e.user!.profilePicture;
            }
          }
          return InkWell(
            onTap: () {
              BlocProvider.of<SelectedConversationCubit>(context)
                  .selectConversation(conversation);

              BlocProvider.of<MessageBloc>(context)
                  .add(LoadMessageEvent(conversation.id, null, null));

              context.goNamed(conversationRouteName,
                  params: {"conversationId": conversation.id});
            },
            child: BlocBuilder<SelectedConversationCubit,
                SelectedConversationState>(
              builder: (context, state) {
                bool isSelected = false;
                if (state is SelectedConversationSuccess) {
                  isSelected = state.conversation.id == conversation.id;
                }
                return Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.09)
                        : null,
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.2),
                      ),
                    ),
                  ),
                  height: 75,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: profilePicture == 'profile_image_url'
                                ? Text(
                                    userName.characters.first.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Image.network(profilePicture),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                conversation.lastMessage != null
                                    ? conversation.lastMessage!.content
                                    : "",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
