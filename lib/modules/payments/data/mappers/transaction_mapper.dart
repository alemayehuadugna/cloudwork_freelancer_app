import '../../domain/entities/transaction.dart';
import '../models/hive/transaction_local_model.dart';
import '../models/json/transaction_remote_model.dart';

class TransactionMapper {
  static TransactionLocalModel toModel(Transaction transaction) {
    return TransactionLocalModel(
      transaction.tnxId,
      transaction.amount,
      transaction.status,
      transaction.tnxFrom,
      TransactionByLocalModel(
        transaction.tnxBy.transferredThrough,
        transaction.tnxBy.accountNumber,
      ),
      transaction.remark,
      transaction.tnxTo,
      transaction.tnxType,
      transaction.serviceCharge,
      transaction.tnxNumber,
      transaction.invoiceImageUrl,
      transaction.tnxTime,
    );
  }

  static Transaction toEntity(TransactionLocalModel transaction) {
    return Transaction(
        tnxId: transaction.tnxId,
        amount: transaction.amount,
        status: transaction.status,
        tnxFrom: transaction.tnxFrom,
        tnxBy: TransactionBy(
          transferredThrough: transaction.tnxBy.transferredThrough,
          accountNumber: transaction.tnxBy.accountNumber,
        ),
        remark: transaction.remark,
        tnxTo: transaction.tnxTo,
        tnxType: transaction.tnxType,
        serviceCharge: transaction.serviceCharge,
        tnxNumber: transaction.tnxNumber,
        invoiceImageUrl: transaction.invoiceImageUrl,
        tnxTime: transaction.tnxTime);
  }

  static List<Transaction> fromJson(json) {
    List<Transaction> transactions = [];
    json.forEach((e) {
      final temp = TransactionRemoteModel.fromJson(e);
      transactions.add(Transaction(
        tnxId: temp.tnxId,
        amount: temp.amount,
        status: temp.status,
        tnxFrom: temp.tnxFrom,
        tnxBy: TransactionBy(
            transferredThrough: temp.tnxBy.transferredThrough,
            accountNumber: temp.tnxBy.accountNumber),
        remark: temp.remark,
        tnxTo: temp.tnxTo,
        tnxType: temp.tnxType,
        serviceCharge: temp.serviceCharge,
        tnxNumber: temp.tnxNumber,
        invoiceImageUrl: temp.invoiceImageUrl,
        tnxTime: temp.tnxTime,
      ));
    });
    return transactions;
  }
}
