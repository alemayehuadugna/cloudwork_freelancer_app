import '../entity/alert.dart';
import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';

abstract class AlertRepository {
  Future<Either<Failure, void>> startAlertService(String userId);
  Future<Either<Failure, void>> sendNotification();
  Future<Either<Failure, void>> loadNotifications(
      String userId, dynamic pagination, dynamic filter);
  Stream<List<Alert>> get notifications;
  Stream<Alert> get newAlert;
  Future<Either<Failure, void>> dispose();
}
