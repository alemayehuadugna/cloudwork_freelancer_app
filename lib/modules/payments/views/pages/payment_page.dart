import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../../_core/di/get_It.dart';
import '../../../dashboard/router.dart';
import '../bloc/transaction_bloc/transaction_bloc.dart';
import '../bloc/wallet_bloc/payment_bloc.dart';
import '../widgets/widgets.dart';

enum TransferType { deposit, withdraw }

const paymentProviders = [
  'CBE',
  'BOA',
  'TeleBirr',
  'CBE birr',
  'Wegagen Bank',
  'Dashn Bank',
  'Amole'
];

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => container<PaymentBloc>()),
        BlocProvider(create: (context) => container<TransactionBloc>()),
      ],
      child: const PaymentDisplay(),
    );
  }
}

class PaymentDisplay extends StatelessWidget {
  const PaymentDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onSave() {
      BlocProvider.of<PaymentBloc>(context).add(GetWalletEvent());
      BlocProvider.of<TransactionBloc>(context)
          .add(const ListTransactionsEvent());
    }

    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: isMobile
            ? BackButton(
                onPressed: () => context.goNamed(homeRouteName),
              )
            : null,
        backgroundColor:
            isMobile ? null : Theme.of(context).colorScheme.background,
        title: Text(
          "Wallet",
          style: isMobile
              ? null
              : TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                onSave();
              },
              shape: const CircleBorder(),
              child: const Icon(Icons.refresh),
            ),
            const SizedBox(width: 5),
            SpeedDial(
              childPadding: const EdgeInsets.only(bottom: 5, top: 5),
              animatedIcon: AnimatedIcons.menu_close,
              backgroundColor: Theme.of(context).colorScheme.primary,
              overlayOpacity: 0,
              direction: SpeedDialDirection.down,
              children: [
                SpeedDialChild(
                    child: const Icon(Icons.receipt_long),
                    label: "Transaction"),
                SpeedDialChild(
                  onTap: () {
                    isMobile
                        ? _showGeneralDialog(
                            context,
                            PaymentForm(
                              transferType: TransferType.withdraw,
                              onSave: onSave,
                            ),
                            "Withdraw Money")
                        : _showDialog(
                            context,
                            PaymentForm(
                              transferType: TransferType.withdraw,
                              onSave: onSave,
                            ),
                            "Withdraw Money");
                  },
                  child: Icon(
                    FontAwesomeIcons.moneyBillTransfer,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  label: "Withdraw",
                ),
                SpeedDialChild(
                  onTap: () {
                    isMobile
                        ? _showGeneralDialog(
                            context,
                            PaymentForm(
                              transferType: TransferType.deposit,
                              onSave: onSave,
                            ),
                            "Deposit Money",
                          )
                        : _showDialog(
                            context,
                            PaymentForm(
                              transferType: TransferType.deposit,
                              onSave: onSave,
                            ),
                            "Deposit Money",
                          );
                  },
                  child: Icon(
                    FontAwesomeIcons.moneyBillTransfer,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  label: "Deposit",
                ),
                SpeedDialChild(
                  onTap: () {
                    isMobile
                        ? _showGeneralDialog(
                            context, const ChapaPayment(), "Chapa")
                        : _showDialog(context, const ChapaPayment(), "Chapa");
                  },
                  child: Icon(
                    FontAwesomeIcons.moneyBillTransfer,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  backgroundColor: Colors.green,
                  label: "Chapa",
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        height: isMobile
            ? MediaQuery.of(context).size.height - 56
            : MediaQuery.of(context).size.height - 112,
        child: Column(
          children: [
            BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                if (state is PaymentInitial) {
                  BlocProvider.of<PaymentBloc>(context).add(GetWalletEvent());
                }
                return SizedBox(
                  child: StaggeredGrid.extent(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    maxCrossAxisExtent: 500,
                    children: [
                      WalletCard(
                        title: state is PaymentLoading
                            ? "Loading..."
                            : "Available Balance",
                        amount:
                            state is PaymentSuccess ? state.data.balance : 0,
                        backgroundColor: const Color(0xFF129BE8),
                        icon: state is PaymentLoading
                            ? const CircularProgressIndicator()
                            : const FaIcon(
                                FontAwesomeIcons.wallet,
                                size: 30,
                                color: Colors.white,
                              ),
                      ),
                      // WalletCard(
                      //   title: state is PaymentLoading
                      //       ? "Loading..."
                      //       : "In Investment",
                      //   amount: state is PaymentSuccess
                      //       ? state.data.inInvestment
                      //       : 0,
                      //   backgroundColor: const Color(0xFF38B653),
                      //   icon: state is PaymentLoading
                      //       ? const CircularProgressIndicator()
                      //       : const FaIcon(
                      //           FontAwesomeIcons.vault,
                      //           size: 30,
                      //           color: Colors.white,
                      //         ),
                      // ),
                      WalletCard(
                        title: state is PaymentLoading
                            ? "Loading..."
                            : "In Transaction",
                        amount: state is PaymentSuccess
                            ? state.data.inTransaction
                            : 0,
                        backgroundColor: const Color(0xFFFF2C00),
                        icon: state is PaymentLoading
                            ? const CircularProgressIndicator()
                            : const FaIcon(
                                FontAwesomeIcons.moneyBillTransfer,
                                size: 30,
                                color: Colors.white,
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: RecentTransactionTable(),
            )
          ],
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context, Widget body, String title) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 600,
            width: 750,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                leading: IconButton(
                  color: Theme.of(context).colorScheme.onBackground,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              body: BlocProvider(
                create: (context) => container<PaymentBloc>(),
                child: body,
              ),
            ),
          ),
        );
      });
}

void _showGeneralDialog(BuildContext context, Widget body, String title) {
  showGeneralDialog(
    context: context,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    pageBuilder: (context, anim, anis) {
      return SafeArea(
        child: SizedBox.expand(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              leading: IconButton(
                color: Theme.of(context).colorScheme.onBackground,
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
            body: BlocProvider(
              create: (context) => container<PaymentBloc>(),
              child: body,
            ),
          ),
        ),
      );
    },
  );
}
