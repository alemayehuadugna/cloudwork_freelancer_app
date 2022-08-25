import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'wallet_local_model.g.dart';

@HiveType(typeId: 20)
class WalletLocalModel extends Equatable {
  @HiveField(0)
  final double balance;

  @HiveField(1)
  final double inTransaction;

  @HiveField(2)
  final double inInvestment;

  const WalletLocalModel({
    required this.balance,
    required this.inTransaction,
    required this.inInvestment,
  });

  @override
  List<Object?> get props => [balance, inTransaction];
}
