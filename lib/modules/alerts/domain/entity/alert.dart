import 'package:equatable/equatable.dart';

class Alert extends Equatable {
  final String id;
  final String title;
  final String message;
  final bool isRead;
  final DateTime sentAt;

  const Alert({
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.sentAt,
  });

  @override
  List<Object?> get props => [id, title, message, isRead, sentAt];
}
