import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String region;
  final String city;
  final String? areaName;
  final String? postalCode;

  const Address(this.region, this.city, this.areaName, this.postalCode);

  @override
  List<Object?> get props => [region, city, areaName, postalCode];
}
