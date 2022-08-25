import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../domain/entities/transaction.dart';
import '../bloc/wallet_bloc/payment_bloc.dart';
import '../pages/payment_page.dart';
import 'custom_text_field.dart';
import 'dialog_bottom_actions.dart';

class PaymentForm extends StatelessWidget {
  const PaymentForm({
    Key? key,
    required this.transferType,
    required this.onSave,
  }) : super(key: key);
  final TransferType transferType;
  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _amountField = TextEditingController();
    final _tnxNumberField = TextEditingController();
    final _accountNumberField = TextEditingController();
    String? transferredThrough = "";
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          onSave();
        } else if (state is PaymentError) {
          showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                      controller: _amountField,
                      validator:
                          RequiredValidator(errorText: "amount is required"),
                      decoration: const InputDecoration(
                        isDense: true,
                        label: Text("Amount"),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFdadce0), width: 0.6),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFdadce0), width: 0.6),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownSearch<String>(
                      dropdownSearchDecoration: const InputDecoration(
                        isDense: true,
                        label: Text("Transfer Through"),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFdadce0), width: 0.6),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFdadce0), width: 0.6),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      popupProps: const PopupProps.menu(
                          showSearchBox: true,
                          menuProps: MenuProps(
                            constraints: BoxConstraints(maxHeight: 300),
                          )),
                      selectedItem: transferredThrough,
                      items: paymentProviders,
                      onChanged: (String? value) {
                        transferredThrough = value;
                      },
                      validator: RequiredValidator(errorText: 'required field'),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _accountNumberField,
                      validator: RequiredValidator(errorText: "input required"),
                      label: "Account Number or Phone Number",
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _tnxNumberField,
                      validator: (value) => null,
                      label: "Transaction Number",
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )),
              DialogBottomActions(
                onSave: () {
                  if (_formKey.currentState!.validate()) {
                    if (transferType == TransferType.deposit) {
                      BlocProvider.of<PaymentBloc>(context).add(
                        DepositEvent(
                          double.parse(_amountField.text),
                          TransactionBy(
                            transferredThrough: transferredThrough!,
                            accountNumber: _accountNumberField.text,
                          ),
                          _tnxNumberField.text,
                        ),
                      );
                    } else if (transferType == TransferType.withdraw) {
                      BlocProvider.of<PaymentBloc>(context).add(
                        WithdrawEvent(
                          double.parse(_amountField.text),
                          TransactionBy(
                            transferredThrough: transferredThrough!,
                            accountNumber: _accountNumberField.text,
                          ),
                        ),
                      );
                    }
                  }
                },
                label: "Deposit",
              )
            ],
          ),
        ),
      ),
    );
  }
}
