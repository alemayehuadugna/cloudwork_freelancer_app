import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'transaction_local_model.g.dart';

@HiveType(typeId: 22)
class TransactionLocalModel extends Equatable {
  @HiveField(0)
  final String tnxId;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String tnxFrom;

  @HiveField(4)
  final TransactionByLocalModel tnxBy;

  @HiveField(5)
  final String? remark;

  @HiveField(6)
  final String tnxTo;

  @HiveField(7)
  final String tnxType;

  @HiveField(8)
  final double serviceCharge;

  @HiveField(9)
  final String tnxNumber;

  @HiveField(10)
  final String invoiceImageUrl;

  @HiveField(11)
  final DateTime tnxTime;

  const TransactionLocalModel(
      this.tnxId,
      this.amount,
      this.status,
      this.tnxFrom,
      this.tnxBy,
      this.remark,
      this.tnxTo,
      this.tnxType,
      this.serviceCharge,
      this.tnxNumber,
      this.invoiceImageUrl,
      this.tnxTime);

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

@HiveType(typeId: 23)
class TransactionByLocalModel extends Equatable {
  @HiveField(0)
  final String transferredThrough;

  @HiveField(1)
  final String accountNumber;

  const TransactionByLocalModel(this.transferredThrough, this.accountNumber);

  @override
  List<Object?> get props => [transferredThrough, accountNumber];
}
