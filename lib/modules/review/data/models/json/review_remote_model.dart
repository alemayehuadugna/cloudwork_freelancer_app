import 'package:json_annotation/json_annotation.dart';

part 'review_remote_model.g.dart';

@JsonSerializable()
class ReviewRemoteModel {
  static parseId(objectId) => objectId['value'];
  @JsonKey(fromJson: parseId, includeIfNull: false, name: "id")
  final String? id;

  final String jobId;
  final String reviewerId;
  final String reviewedId;
  final String title;
  final String comment;
  final double rate;
  final DateTime? createdAt;

  ReviewRemoteModel(this.id, this.jobId, this.reviewerId, this.reviewedId,
      this.title, this.comment, this.rate, this.createdAt);

  factory ReviewRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewRemoteModelToJson(this);
}
