import 'package:json_annotation/json_annotation.dart';

part 'result_page_remote_model.g.dart';

@JsonSerializable()
class ResultPageRemoteModel {
  final int current;
  final int pageSize;
  final int totalPages;
  final int totalElements;
  final bool first;
  final bool last;

  ResultPageRemoteModel({
    required this.current,
    required this.pageSize,
    required this.totalPages,
    required this.totalElements,
    required this.first,
    required this.last,
  });

  factory ResultPageRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$ResultPageRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$ResultPageRemoteModelToJson(this);
  }
}
