import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_core/error/exceptions.dart';

const sessionBox = 'sessions';

abstract class ChatLocalDataSource {
  Future<void> cacheSession(String userId, String sessionId);
  Future<String> getCachedSession(String userId);
  Future<void> remoteSession();
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final HiveInterface hive;

  ChatLocalDataSourceImpl({required this.hive});

  @override
  Future<void> cacheSession(String userId, String sessionId) async {
    try {
      var sessionStore = await hive.openLazyBox(sessionBox);
      sessionStore.put(userId, sessionId);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<String> getCachedSession(String userId) async {
    final sessionStore = await hive.openLazyBox(sessionBox);
    final cachedSessionId = await sessionStore.get(userId);
    if (cachedSessionId != null) {
      return cachedSessionId;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> remoteSession() async {
    // final sessionStore = await hive.openLazyBox(sessionBox);
    // sessionStore.deleteAll(keys);
    throw UnimplementedError();
  }
}
