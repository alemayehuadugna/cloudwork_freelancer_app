import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router.dart';


class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t Have Account?'),
        TextButton(
          onPressed: () {
            context.goNamed(createAccountRouteName);
          },
          child: const Text("Sign Up"),
        ),
      ],
    );
  }
}
