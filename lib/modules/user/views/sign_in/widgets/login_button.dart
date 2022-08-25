import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;
    void _onFormSubmitted() async {
      if (_formKey.currentState!.validate()) {
        var _loginBloc = BlocProvider.of<LoginBloc>(context);
        _loginBloc.add(LoginInSubmitted(
          email: _emailController.text,
          password: _passwordController.text,
        ));
      }
    }

    return ElevatedButton(
      onPressed: state is! LoginLoading ? _onFormSubmitted : null,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(56)),
      ),
      child: state is LoginLoading
          ? const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            )
          : const Text(
              "Log In",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
    );
  }
}
