import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'common_model.g.dart';

@HiveType(typeId: 8)
class RatingModel extends Equatable {
  @HiveField(0)
  final double rate;

  @HiveField(1)
  final double totalRate;

  @HiveField(2)
  final double totalRaters;

  const RatingModel(this.rate, this.totalRate, this.totalRaters);

  @override
  List<Object?> get props => [rate, totalRate, totalRaters];
}

@HiveType(typeId: 9)
class RangeDateModel extends Equatable {
  @HiveField(0)
  final DateTime start;

  @HiveField(1)
  final DateTime end;

  const RangeDateModel(this.start, this.end);

  @override
  List<Object?> get props => [start, end];
}

@HiveType(typeId: 10)
class AddressModel extends Equatable {
  @HiveField(0)
  final String region;

  @HiveField(1)
  final String city;

  @HiveField(2)
  final String? areaName;

  @HiveField(3)
  final String? postalCode;

  const AddressModel(this.region, this.city, this.areaName, this.postalCode);

  @override
  List<Object?> get props => [region, city, areaName, postalCode];
}
