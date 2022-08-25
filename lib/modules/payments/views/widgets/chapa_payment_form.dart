import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../_shared/interface/widgets/show_top_flash.dart';
import '../bloc/wallet_bloc/payment_bloc.dart';
import 'dialog_bottom_actions.dart';

class ChapaPayment extends StatelessWidget {
  const ChapaPayment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _amountField = TextEditingController();
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: SpinKitFadingCircle(
          color: Theme.of(context).colorScheme.secondary,
          size: 50.0,
        ),
      ),
      overlayColor: Theme.of(context).colorScheme.primary,
      overlayOpacity: 0.2,
      child: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentLoading) {
            context.loaderOverlay.show();
          } else if (state is PaymentSuccess) {
            context.loaderOverlay.hide();
            Navigator.of(context, rootNavigator: true).pop();
            final Uri _url = Uri.parse(state.data);
            launchUrl(_url);
          } else if (state is PaymentError) {
            context.loaderOverlay.hide();
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
                      SvgPicture.asset(
                        "assets/icons/chapa.svg",
                        height: 100,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                          ],
                          controller: _amountField,
                          validator: RequiredValidator(
                              errorText: "amount is required"),
                          decoration: const InputDecoration(
                            isDense: true,
                            label: Text("Amount"),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFdadce0), width: 0.6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFdadce0), width: 0.6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                DialogBottomActions(
                  onSave: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<PaymentBloc>(context).add(
                          ChapaDepositEvent(double.parse(_amountField.text)));
                    }
                  },
                  label: "Deposit",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
