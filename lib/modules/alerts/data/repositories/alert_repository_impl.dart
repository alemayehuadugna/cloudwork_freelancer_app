import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../_core/error/failures.dart';
import '../../domain/entity/alert.dart';
import '../../domain/repo/alert_repository.dart';
import '../mapper/alert_mapper.dart';

class AlertRepositoryImpl implements AlertRepository {
  final Socket socket;
  final Dio dio;
  final List<Alert> notificationList = [];
  var _notifications = StreamController<List<Alert>>();
  var _newAlert = StreamController<Alert>();

  AlertRepositoryImpl({required this.socket, required this.dio});

  @override
  Stream<Alert> get newAlert => _newAlert.stream.asBroadcastStream();

  @override
  Stream<List<Alert>> get notifications =>
      _notifications.stream.asBroadcastStream();

  @override
  Future<Either<Failure, void>> sendNotification() async {
    try {
      await dio.post('/transactions/chapa/hook', data: {'test': "hello work"});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("error sending notification"));
    }
  }

  @override
  Future<Either<Failure, void>> startAlertService(String userId) async {
    try {
      socket.on('new-notification', (data) {
        _newAlert.sink.add(AlertMapper.fromJson([data]).first);
        notificationList.insert(0, AlertMapper.fromJson([data]).first);
        _notifications.sink.add(notificationList);
      });

      socket.emitWithAck('load-notification', {'userId': userId}, ack: (res) {
        notificationList.addAll(AlertMapper.fromJson(res['data']));
        _notifications.sink.add(notificationList);
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("message"));
    }
  }

  @override
  Future<Either<Failure, void>> dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> loadNotifications(
      String userId, pagination, filter) {
    // TODO: implement loadNotifications
    throw UnimplementedError();
  }
}
