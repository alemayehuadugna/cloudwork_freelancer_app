import 'package:get_it/get_it.dart';

import 'data/data_sources/local_data_source.dart';
import 'data/repositories/chat_repository_impl.dart';
import 'domain/repo/chat_repository.dart';
import 'domain/usecases/list_conversation.dart';
import 'domain/usecases/list_message.dart';
import 'domain/usecases/load_messages.dart';
import 'domain/usecases/send_message.dart';
import 'domain/usecases/start_socket_service.dart';
import 'domain/usecases/start_conversation.dart';
import 'views/bloc/conversation_bloc/conversation_bloc.dart';
import 'views/bloc/message_bloc/message_bloc.dart';
import 'views/bloc/selected_conversation/selected_conversation_cubit.dart';

void injectChat(GetIt container) {
  //! Data Source Injection
  container.registerLazySingleton<ChatLocalDataSource>(
    () => ChatLocalDataSourceImpl(hive: container()),
  );
  container.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      socket: container(),
      localDataSource: container(),
    ),
  );

  //! Usecase Injection
  container.registerLazySingleton(() => StartChatUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => StartConversationUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => ListConversationUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SendMessageUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => ListMessageUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => LoadMessagesUseCase(
        repository: container(),
      ));

  //! Bloc Injection
  container.registerFactory(() => ConversationBloc(
        startConversation: container(),
        listConversation: container(),
        sendMessage: container(),
      ));
  container.registerFactory(() => MessageBloc(
        listMessage: container(),
        loadMessage: container(),
      ));
  container.registerFactory(() => SelectedConversationCubit());
}
