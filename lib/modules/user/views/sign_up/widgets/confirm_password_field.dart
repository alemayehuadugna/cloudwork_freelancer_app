import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ConfirmPasswordField extends StatelessWidget {
  ConfirmPasswordField({
    Key? key,
    required this.isPasswordVisible,
    required this.controller,
    required this.password,
  }) : super(key: key);

  final bool isPasswordVisible;
  final TextEditingController controller;
  final String password;

  final firstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'First Name is required'),
    MinLengthValidator(
      3,
      errorText: 'First Name must be at least 3 character long',
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    print(password);
    return TextFormField(
      validator: (val) => MatchValidator(errorText: 'passwords do not match')
          .validateMatch(val!, password),
      obscureText: !isPasswordVisible,
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Confirm",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
