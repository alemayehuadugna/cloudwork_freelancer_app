import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register_bloc.dart';


class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    void _onFormSubmitted() async {
      if (formKey.currentState!.validate()) {
        final _registerBloc = BlocProvider.of<RegisterBloc>(context);
        _registerBloc.add(
          RegistrationRequested(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            phone: phoneController.text,
            email: emailController.text,
            password: passwordController.text,
            hasAgreed: true,
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                minimumSize:
                    MaterialStateProperty.all(const Size.fromHeight(56)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)))),
            onPressed: state is! RegisterLoading ? _onFormSubmitted : null,
            child: const Text(
              "Sign Up",
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
