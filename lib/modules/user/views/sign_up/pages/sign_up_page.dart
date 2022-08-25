import 'package:CloudWork_Freelancer/_core/di/get_It.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register_bloc.dart';
import 'sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: BlocProvider(
          create: (context) => container<RegisterBloc>(),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
