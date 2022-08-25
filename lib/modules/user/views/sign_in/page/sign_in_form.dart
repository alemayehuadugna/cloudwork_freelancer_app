import 'package:CloudWork_Freelancer/_shared/interface/layout/widgets/cloudwork_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../bloc/login_bloc.dart';
import '../widgets/widgets.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  void changePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showTopSnackBar(
            title: Text(
              "Error",
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 16,
              ),
            ),
            content: Text(state.error),
            icon: Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
            ),
            context: context,
          );
        }
      },
      builder: (context, state) {
        bool isMobile = ResponsiveWrapper.of(context).isMobile;
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(40, 48, 40, 36),
            width: isMobile ? null : 448,
            decoration: isMobile
                ? null
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                    border:
                        Border.all(width: 0.7, color: const Color(0xffdadce0)),
                  ),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CloudworkLogo(height: 60),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 40),
                    EmailInput(controller: _emailController),
                    const SizedBox(height: 15),
                    PasswordInput(
                      passwordVisible: passwordVisible,
                      controller: _passwordController,
                      changePasswordVisibility: changePasswordVisibility,
                    ),
                    const SizedBox(height: 10),
                    const ForgetPasswordButton(),
                    const SizedBox(height: 40),
                    LoginButton(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 40),
                    const SignUpButton()
                  ]),
            ),
          ),
        );
      },
    );
  }
}
