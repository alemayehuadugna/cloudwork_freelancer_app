import 'package:json_annotation/json_annotation.dart';

part 'alert_remote_model.g.dart';

@JsonSerializable()
class AlertRemoteModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: '_title')
  final String title;
  @JsonKey(name: '_message')
  final String message;
  @JsonKey(name: '_isRead')
  final bool isRead;
  @JsonKey(name: '_sentAt')
  final DateTime sentAt;

  AlertRemoteModel(
      {required this.id,
      required this.title,
      required this.message,
      required this.isRead,
      required this.sentAt});

  factory AlertRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$AlertRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlertRemoteModelToJson(this);
}
