import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String? id;
  final String jobId;
  final String reviewerId;
  final String reviewedId;
  final String title;
  final String comment;
  final double rate;
  final DateTime? createdAt;

  const Review(
    this.id, {
    required this.jobId,
    required this.reviewerId,
    required this.reviewedId,
    required this.title,
    required this.comment,
    required this.rate,
    required this.createdAt,
  });

  @override
  List<Object?> get props =>
      [id, jobId, reviewedId, reviewerId, title, comment, rate, createdAt];
}
