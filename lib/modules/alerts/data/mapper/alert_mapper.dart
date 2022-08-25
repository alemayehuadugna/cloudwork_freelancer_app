import 'package:CloudWork_Freelancer/modules/alerts/data/model/json/alert_remote_model.dart';

import '../../domain/entity/alert.dart';

class AlertMapper {
  static List<Alert> fromJson(dynamic json) {
    List<Alert> alerts = [];
    json.forEach((e) {
      final temp = AlertRemoteModel.fromJson(e);
      alerts.add(Alert(
          id: temp.id,
          title: temp.title,
          message: temp.message,
          isRead: temp.isRead,
          sentAt: temp.sentAt));
    });

    return alerts;
  }
}
