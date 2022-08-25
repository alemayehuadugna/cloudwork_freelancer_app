import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String tnxId;
  final double amount;
  final String status;
  final String tnxFrom;
  final TransactionBy tnxBy;
  final String? remark;
  final String tnxTo;
  final String tnxType;
  final double serviceCharge;
  final String tnxNumber;
  final String invoiceImageUrl;
  final DateTime tnxTime;

  const Transaction(
      {required this.tnxId,
      required this.amount,
      required this.status,
      required this.tnxFrom,
      required this.tnxBy,
      required this.remark,
      required this.tnxTo,
      required this.tnxType,
      required this.serviceCharge,
      required this.tnxNumber,
      required this.invoiceImageUrl,
      required this.tnxTime});

  @override
  List<Object?> get props => [
        tnxId,
        amount,
        status,
        tnxFrom,
        tnxBy,
        remark,
        tnxTo,
        tnxType,
        serviceCharge,
        tnxNumber,
        invoiceImageUrl,
        tnxTime
      ];
}

class TransactionBy extends Equatable {
  final String transferredThrough;
  final String accountNumber;

  const TransactionBy(
      {required this.transferredThrough, required this.accountNumber});

  @override
  List<Object?> get props => [transferredThrough, accountNumber];
}
