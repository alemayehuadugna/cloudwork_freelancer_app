import 'package:equatable/equatable.dart';

import 'message.dart';

class ConversationUser {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePicture;

  ConversationUser(this.id, this.firstName, this.lastName, this.profilePicture);
}

class Member extends Equatable {
  final String userId;
  final String userType;
  final ConversationUser? user;

  const Member(
    this.user, {
    required this.userId,
    required this.userType,
  });

  @override
  List<Object?> get props => [
        userId,
        userType,
        user,
      ];
}

class Conversation extends Equatable {
  final String id;
  final List<Member> members;
  Message? lastMessage;

  Conversation(
    this.lastMessage, {
    required this.id,
    required this.members,
  });

  @override
  List<Object?> get props => [id, members, lastMessage];
}
