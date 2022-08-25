import 'package:CloudWork_Freelancer/modules/user/data/models/hive/detail_local_user_model.dart';
import 'package:hive/hive.dart';

import '../../../../_core/error/exceptions.dart';
import '../../../../_core/utils/constants.dart';
import '../../domain/entities/basic_user.dart';
import '../../domain/entities/detail_user.dart';
import '../models/hive/basic_local_user.dart';

abstract class UserLocalDataSource {
  Future<BasicUser> getCachedBasicUser();

  Future<DetailUser> getCachedDetailUser();

  Future<String> getCachedToken();

  Future<void> cacheToken(String token);

  Future<void> cacheBasicUser(BasicLocalUser basicUserToCache);

  Future<void> cacheDetailUser(DetailUserLocalModel detailLocalUser);

  Future<void> removeToken();

  Future<void> removeBasicUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final HiveInterface hive;

  UserLocalDataSourceImpl({required this.hive});

  @override
  Future<void> cacheToken(String token) async {
    try {
      var tokenBox = await hive.openBox('token');
      tokenBox.put(cachedTokenKey, token);
      // tokenBox.close();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheBasicUser(BasicLocalUser basicUserToCache) async {
    try {
      var userBox = await hive.openLazyBox<BasicLocalUser>('user');
      userBox.put(cachedUserKey, basicUserToCache);
      // if (Hive.isBoxOpen('user'))userBox.close();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheDetailUser(DetailUserLocalModel detailLocalUser) async {
    try {
      var userBox = await hive.openLazyBox<DetailUserLocalModel>('detail_user');
      userBox.put(cachedDetailUserKey, detailLocalUser);
      // if (userBox.isOpen) userBox.close();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<BasicUser> getCachedBasicUser() async {
    final userBox = await hive.openLazyBox('user');
    final cachedData = await userBox.get(cachedUserKey);
    // if (userBox.isOpen) userBox.close();
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<DetailUser> getCachedDetailUser() async {
    final userBox = await hive.openBox('detail_user');
    final cachedUser = userBox.get(cachedDetailUserKey);
    // if (userBox.isOpen) userBox.close();
    if (cachedUser != null) {
      return Future.value(cachedUser);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getCachedToken() async {
    final tokenBox = await hive.openBox('token');
    final cachedData = tokenBox.get(cachedTokenKey);
    // tokenBox.close();
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> removeToken() async {
    var tokenBox = await hive.openBox('token');
    tokenBox.delete(cachedTokenKey);
    tokenBox.close();
    return;
  }

  @override
  Future<void> removeBasicUser() async {
    final userBox = await hive.openLazyBox<BasicLocalUser>('user');
    userBox.delete(cachedUserKey);
    // if (userBox.isOpen) userBox.close();
    return;
  }
}
