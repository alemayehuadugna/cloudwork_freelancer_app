// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewRemoteModel _$ReviewRemoteModelFromJson(Map<String, dynamic> json) =>
    ReviewRemoteModel(
      ReviewRemoteModel.parseId(json['id']),
      json['jobId'] as String,
      json['reviewerId'] as String,
      json['reviewedId'] as String,
      json['title'] as String,
      json['comment'] as String,
      (json['rate'] as num).toDouble(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ReviewRemoteModelToJson(ReviewRemoteModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['jobId'] = instance.jobId;
  val['reviewerId'] = instance.reviewerId;
  val['reviewedId'] = instance.reviewedId;
  val['title'] = instance.title;
  val['comment'] = instance.comment;
  val['rate'] = instance.rate;
  val['createdAt'] = instance.createdAt?.toIso8601String();
  return val;
}
