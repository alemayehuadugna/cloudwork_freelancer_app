part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  @override
  List<Object?> get props => [];
}

class PaymentLoading extends PaymentState {
  @override
  List<Object?> get props => [];
}

class PaymentSuccess<T> extends PaymentState {
  final T? data;

  const PaymentSuccess({this.data});

  @override
  List<T?> get props => [data];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError(this.message);

  @override
  List<Object?> get props => [message];
}
