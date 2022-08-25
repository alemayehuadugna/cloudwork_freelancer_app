import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../_core/error/failures.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/repo/chat_repository.dart';
import '../data_sources/local_data_source.dart';
import '../mappers/conversation_mapper.dart';
import '../mappers/message_mapper.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource localDataSource;
  final Socket socket;
  final List<Conversation> conversationList = [];
  Map<String, List<Message>> _mapListMessages = <String, List<Message>>{};
  var _userConversations;
  var _messages;

  ChatRepositoryImpl({
    required this.localDataSource,
    required this.socket,
  });

  @override
  Stream<List<Conversation>> get conversations =>
      _userConversations.stream.asBroadcastStream();

  @override
  Stream<Map<String, List<Message>>> get messages =>
      _messages.stream.asBroadcastStream();

  @override
  Future<Either<Failure, void>> initChat(String userId) async {
    try {
      final sessionId = await localDataSource.getCachedSession(userId);
      socket.auth = {
        "userId": userId,
        "sessionId": sessionId,
      };
    } catch (e) {
      socket.auth = {"userId": userId};
    }

    try {
      socket.connect();
      _userConversations = StreamController<List<Conversation>>();
      _messages = StreamController<Map<String, List<Message>>>();
      _mapListMessages = <String, List<Message>>{};

      socket.on("new-message", (data) {
        // print("new-message");
        _mapListMessages[data['_conversationId']]!
            .insert(0, MessageMapper.fromJson([data]).first);
        _messages.sink.add(_mapListMessages);
        for (int i = 0; i < conversationList.length; i++) {
          if (conversationList[i].id == data['_conversationId']) {
            conversationList[i].lastMessage =
                MessageMapper.fromJson([data]).first;
            _userConversations.sink.add(conversationList);
            break;
          }
        }
      });

      socket.on("new-conversation", (data) {
        conversationList.addAll(ConversationMapper.fromJson([data]));
        _userConversations.sink.add(conversationList);
        socket.emit('join-conversation', data);
      });

      socket.emitWithAck(
          "list-conversation", {"userId": userId, "userType": "Freelancer"},
          ack: (response) {
        // print("list-conversation-with-lastMessage: ${response['data']}");
        conversationList.addAll(ConversationMapper.fromJson(response['data']));
        for (var element in conversationList) {
          _mapListMessages[element.id] = [];
        }
        _userConversations.sink.add(conversationList);
      });

      socket.on("/session/me", (data) {
        try {
          localDataSource.cacheSession(userId, data['sessionId']);
        } catch (e) {
          print("cache error: $e");
        }
      });

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      String conversationId, dynamic content) async {
    try {
      socket.emitWithAck('send-message',
          {'conversationId': conversationId, 'content': content}, ack: (res) {
        // print("send message response: $res");
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("error Sending message"));
    }
  }

  @override
  Future<Either<Failure, void>> startConversation(String fid, String cid) async {
    const String fId = "bf8814cb-5cdd-4e48-9987-2e994a961118";
    const String cId = '7a6f70f8-2bfb-4230-9bf3-c13432e71cca';
    // 		userType: string;
    // userId: string
    var members = [];
    members.add({'userType': 'Freelancer', 'userId': fId});
    members.add({'userType': 'Client', 'userId': cId});
    var payload = {'members': members, "id": "123"};
    try {
      socket.emitWithAck('create-conversation', payload, ack: (conversation) {
        print("create-conversation => ack: $conversation");
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("message"));
    }
  }

  @override
  Future<Either<Failure, void>> loadMessages(
      String conversationId, dynamic pagination, dynamic filter) async {
    try {
      socket.emitWithAck('load-message', {
        "conversationId": conversationId,
        'pagination': pagination,
        "filter": filter
      }, ack: (res) {
        _mapListMessages[conversationId] = MessageMapper.fromJson(res['data']);
        print("loadMessages: ack: ");
        _messages.sink.add(_mapListMessages);
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("error Sending message"));
    }
  }

  @override
  Future<Either<Failure, void>> dispose() async {
    try {
      socket.dispose();
      socket.destroy();
      socket.close();
      socket.disconnect();
      _userConversations.close();
      // _messages.close();
      conversationList.clear();
      // _mapListMessages.clear();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Error Disposing Service"));
    }
  }
}
