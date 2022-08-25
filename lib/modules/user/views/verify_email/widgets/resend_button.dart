import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../domain/entities/basic_user.dart';
import '../bloc/verify_email_bloc.dart';

class ResendButton extends StatelessWidget {
  const ResendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onPressed() async {
      final _authBloc = BlocProvider.of<AuthBloc>(context);
      final _verifyBloc = BlocProvider.of<VerifyEmailBloc>(context);
      if (_authBloc.state is Unverified) {
        final BasicUser user = _authBloc.state.props[0] as BasicUser;
        _verifyBloc.add(ResendOTPRequested(email: user.email));
      }
    }

    return BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: state is ResendOTPLoading ? null : onPressed,
                child: const Text("Resend"),
              ),
            ],
          ),
        );
      },
    );
  }
}
