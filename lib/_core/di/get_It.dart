import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../modules/bid/injection.dart';
import '../../modules/alerts/injection.dart';
import '../../modules/chat/injection.dart';
import '../../modules/job/injection.dart';
import '../../modules/payments/injection.dart';
import '../../modules/review/injection.dart';
import '../../modules/user/injection.dart';
import '../dio_config.dart';
import '../hive_config.dart';
import '../socket_config.dart';

final container = GetIt.instance;

Future<void> init() async {
  //! Core
  final Dio dio = await DioConfig.init();
  final HiveInterface hive = await HiveConfig.init();
  final Socket socket = initSocket();
  container.registerLazySingleton(() => socket);
  container.registerLazySingleton(() => dio);
  container.registerLazySingleton(() => hive);

  //! injection of user module
  injectUsers(container);

  //! injection of job module
  injectJobs(container);

  //! injection of payment module
  injectPayments(container);

  //! injection of chat module
  injectChat(container);

  //! injection of alert module
  injectAlert(container);

  //! injection of review module
  injectReview(container);

}
