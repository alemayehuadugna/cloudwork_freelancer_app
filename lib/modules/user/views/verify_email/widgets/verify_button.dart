import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../domain/entities/basic_user.dart';
import '../bloc/verify_email_bloc.dart';

class VerifyButton extends StatelessWidget {
  const VerifyButton({
    Key? key,
    required this.formKey,
    required this.fieldOne,
    required this.fieldTwo,
    required this.fieldThree,
    required this.fieldFour,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController fieldOne;
  final TextEditingController fieldTwo;
  final TextEditingController fieldThree;
  final TextEditingController fieldFour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 30, 50, 15),
      child: BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
        builder: (context, state) {
          void _onSubmitted() async {
            if (formKey.currentState!.validate()) {
              final _authBloc = BlocProvider.of<AuthBloc>(context);
              final _verifyBloc = BlocProvider.of<VerifyEmailBloc>(context);
              String otp =
                  '${fieldOne.text}${fieldTwo.text}${fieldThree.text}${fieldFour.text}';
              if (_authBloc.state is Unverified) {
                final BasicUser user = _authBloc.state.props[0] as BasicUser;
                _verifyBloc.add(VerifyEmailRequested(
                  code: otp,
                  email: user.email,
                ));
              }
            }
          }

          return ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(52)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
            ),
            onPressed: _onSubmitted,
            child: const Text(
              "Verify",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          );
        },
      ),
    );
  }
}
