import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final double balance;

  final double inTransaction;

  final double inInvestment;

  const Wallet({
    required this.balance,
    required this.inTransaction,
    required this.inInvestment,
  });

  @override
  List<Object?> get props => [balance, inTransaction];
}
