import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../_core/cqrs.dart';
import '../../domain/entities/transaction.dart';
import '../bloc/transaction_bloc/transaction_bloc.dart';

class RecentTransactionTable extends StatefulWidget {
  const RecentTransactionTable({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentTransactionTable> createState() => _RecentTransactionTableState();
}

class _RecentTransactionTableState extends State<RecentTransactionTable> {
  List<DataColumn> columns = const [
    DataColumn(
      label: Text(
        'Date',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Recipient',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Transaction Id',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Status',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Amount',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  ];

  final PaginatorController _controller = PaginatorController();
  int _limit = PaginatedDataTable.defaultRowsPerPage;
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    print("Recent_transaction_table");
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionInitial) {
          BlocProvider.of<TransactionBloc>(context).add(ListTransactionsEvent(
              pagination: {'page': _page, 'limit': _limit}));
        }
        if (state is TransactionLoaded) {
          return SizedBox(
            width: double.infinity,
            child: AsyncPaginatedDataTable2(
              minWidth: 600,
              columnSpacing: 15,
              showCheckboxColumn: false,
              autoRowsToHeight: true,
              header: const Text("Recent Transaction"),
              columns: columns,
              rowsPerPage: _limit,
              controller: _controller,
              initialFirstRowIndex:
                  (state.transactions.page.current - 1) * _limit,
              onRowsPerPageChanged: (value) {
                if (value != _limit) {
                  BlocProvider.of<TransactionBloc>(context).add(
                    ListTransactionsEvent(
                      pagination: {'page': _page, 'limit': value},
                    ),
                  );
                }
                _limit = value!;
              },
              onPageChanged: (value) {
                _page = ((value / _limit) + 1).toInt();
                BlocProvider.of<TransactionBloc>(context).add(
                  ListTransactionsEvent(
                    pagination: {'page': _page, 'limit': _limit},
                  ),
                );
              },
              source: TransactionDataSourceAsync(
                context: context,
                result: state.transactions,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class TransactionDataSourceAsync extends AsyncDataTableSource {
  final PaginatedQueryResult<List<Transaction>> result;
  final BuildContext context;

  TransactionDataSourceAsync({
    required this.context,
    required this.result,
  });

  @override
  Future<AsyncRowsResponse> getRows(int start, int end) async {
    var row = AsyncRowsResponse(
      result.page.totalElements,
      result.data!.map(
        (transaction) {
          return DataRow(
            key: ValueKey<String>(transaction.tnxId),
            onSelectChanged: (value) {},
            cells: [
              DataCell(
                  Text(DateFormat.MMMMEEEEd().format(transaction.tnxTime))),
              DataCell(Text(
                transaction.tnxTo,
                overflow: TextOverflow.ellipsis,
              )),
              DataCell(Text(
                transaction.tnxId,
                overflow: TextOverflow.ellipsis,
              )),
              DataCell(Text(transaction.status)),
              DataCell(Text('${transaction.amount}')),
            ],
          );
        },
      ).toList(),
    );

    return row;
  }
}
