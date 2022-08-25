import 'package:equatable/equatable.dart';

class RangeDate extends Equatable {
  final DateTime start;
  final DateTime end;

  const RangeDate(this.start, this.end);

  @override
  List<Object?> get props => [start, end];
}
