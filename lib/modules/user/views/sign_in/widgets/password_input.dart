import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PasswordInput extends StatelessWidget {
  PasswordInput({
    Key? key,
    required this.passwordVisible,
    required this.controller,
    required this.changePasswordVisibility,
  }) : super(key: key);

  final TextEditingController controller;
  final bool passwordVisible;
  final Function changePasswordVisibility;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: passwordValidator,
      obscureText: !passwordVisible,
      decoration: InputDecoration(
        isDense: false,
        labelText: "Password",
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            changePasswordVisibility();
          },
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      controller: controller,
    );
  }
}
