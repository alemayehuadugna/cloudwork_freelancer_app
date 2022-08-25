import 'package:CloudWork_Freelancer/_shared/interface/widgets/show_top_flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/interface/layout/widgets/widgets.dart';
import '../../../router.dart';
import '../bloc/register_bloc.dart';
import '../widgets/widgets.dart';

class User {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;

  User(this.firstName, this.lastName, this.phone, this.email, this.password,
      this.confirmPassword);
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _passwordVisible = false;
  // String password = '';
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // void onPasswordChanged(value) {
  //   password = value;
  // }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          showTopSnackBar(
              title: const Text('Registration Error'),
              content: Text(state.error),
              icon: const Icon(Icons.error),
              context: context);
        }
      },
      child: SingleChildScrollView(
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
              children: [
                const CloudworkLogo(height: 60),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ResponsiveRowColumn(
                  columnSpacing: 24,
                  rowSpacing: 8,
                  layout: isMobile
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  children: [
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: FirstName(controller: _firstNameController),
                    ),
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: LastName(controller: _lastNameController),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                PhoneField(controller: _phoneController),
                const SizedBox(height: 24),
                EmailField(controller: _emailController),
                const SizedBox(height: 24),
                ResponsiveRowColumn(
                  columnSpacing: 24,
                  rowSpacing: 8,
                  layout: isMobile
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  children: [
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: PasswordField(
                        isPasswordVisible: _passwordVisible,
                        controller: _passwordController,
                        // onChanged: onPasswordChanged,
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: ConfirmPasswordField(
                        isPasswordVisible: _passwordVisible,
                        controller: _confirmPasswordController,
                        password: _passwordController.text,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Checkbox(
                      value: _passwordVisible,
                      onChanged: (value) {
                        setState(() {
                          _passwordVisible = value ?? false;
                        });
                      },
                    ),
                    const Text('Show Password')
                  ],
                ),
                const SizedBox(height: 30),
                SignUpButton(
                  emailController: _emailController,
                  firstNameController: _firstNameController,
                  formKey: _formKey,
                  lastNameController: _lastNameController,
                  passwordController: _passwordController,
                  phoneController: _phoneController,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already Have Account?'),
                    TextButton(
                      onPressed: () {
                        context.goNamed(loginRouteName);
                      },
                      child: const Text("Sign In"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
