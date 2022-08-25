part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class DepositEvent extends PaymentEvent {
  final double amount;
  final TransactionBy tnxBy;
  final String tnxNumber;

  const DepositEvent(this.amount, this.tnxBy, this.tnxNumber);

  @override
  List<Object> get props => [amount, tnxBy, tnxNumber];
}

class WithdrawEvent extends PaymentEvent {
  final double amount;
  final TransactionBy tnxBy;

  const WithdrawEvent(this.amount, this.tnxBy);

  @override
  List<Object> get props => [];
}

class ChapaDepositEvent extends PaymentEvent {
  final double amount;

  const ChapaDepositEvent(this.amount);

  @override
  List<Object> get props => [amount];
}

class GetWalletEvent extends PaymentEvent {
  @override
  List<Object> get props => [];
}
