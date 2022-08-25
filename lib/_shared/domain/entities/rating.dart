import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final double rate;
  final double totalRate;
  final double totalRaters;

  const Rating(this.rate, this.totalRate, this.totalRaters);

  @override
  List<Object?> get props => [rate, totalRate, totalRaters];
}
