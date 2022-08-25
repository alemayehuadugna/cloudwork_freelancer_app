import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../domain/entities/conversation.dart';
import '../bloc/selected_conversation/selected_conversation_cubit.dart';

class MessageHeader extends StatelessWidget {
  const MessageHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedConversationCubit, SelectedConversationState>(
      builder: (context, state) {
        Conversation conversation = Conversation(null, id: "", members: []);
        if (state is SelectedConversationSuccess) {
          conversation = state.conversation;
        }
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
              return SizedBox(
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jane Doe",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "online",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.phone)),
                      const SizedBox(width: 10),
                      PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          const PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.visibility),
                              title: Text('Profile'),
                            ),
                          ),
                          const PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.delete),
                              title: Text('Delete'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}

