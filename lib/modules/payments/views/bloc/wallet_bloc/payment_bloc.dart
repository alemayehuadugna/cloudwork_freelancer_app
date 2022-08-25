import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecase.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/usecases/deposit.dart';
import '../../../domain/usecases/deposit_chapa.dart';
import '../../../domain/usecases/get_wallet.dart';
import '../../../domain/usecases/withdraw.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final DepositUseCase _deposit;
  final WithdrawUseCase _withdraw;
  final GetWalletUseCase _getWallet;
  final DepositChapaUseCase _depositChapa;

  PaymentBloc({
    required DepositUseCase depositUseCase,
    required WithdrawUseCase withdrawUseCase,
    required GetWalletUseCase getWalletUseCase,
    required DepositChapaUseCase depositChapaUseCase,
  })  : _deposit = depositUseCase,
        _withdraw = withdrawUseCase,
        _getWallet = getWalletUseCase,
        _depositChapa = depositChapaUseCase,
        super(PaymentInitial()) {
    on<DepositEvent>(_depositEvent);
    on<ChapaDepositEvent>(_depositChapaEvent);
    on<WithdrawEvent>(_withdrawEvent);
    on<GetWalletEvent>(_getWalletEvent);
  }

  void _depositChapaEvent(
    ChapaDepositEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    final result = await _depositChapa(event.amount);
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return PaymentError(error.message);
        }
        return const PaymentError('Error Occurred while Depositing');
      },
      (checkoutUrl) => PaymentSuccess<String>(data: checkoutUrl),
    ));
  }

  void _depositEvent(DepositEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());

    final result = await _deposit(
      DepositParams(event.amount, event.tnxBy, event.tnxNumber),
    );
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return PaymentError(error.message);
        }
        return const PaymentError('Error Occurred while Depositing');
      },
      (r) => const PaymentSuccess(),
    ));
  }

  void _withdrawEvent(WithdrawEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    final result = await _withdraw(WithdrawParams(event.amount, event.tnxBy));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return PaymentError(error.message);
        }
        return const PaymentError('Error Occurred while Withdrawing');
      },
      (r) => const PaymentSuccess(),
    ));
  }

  void _getWalletEvent(GetWalletEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    // await Future.delayed(Duration(seconds: 2));
    final result = await _getWallet(NoParams());
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return PaymentError(error.message);
        }
        return const PaymentError('Error Getting your Wallet');
      },
      (wallet) => PaymentSuccess<Wallet>(data: wallet),
    ));
  }
}
