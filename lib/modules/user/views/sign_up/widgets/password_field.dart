import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PasswordField extends StatelessWidget {
  PasswordField({
    Key? key,
    required this.isPasswordVisible,
    required this.controller,
    // required this.onChanged
  }) : super(key: key);

  final bool isPasswordVisible;
  final TextEditingController controller;
  // final Function(String value) onChanged;
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: passwordValidator,
      obscureText: !isPasswordVisible,
      // onChanged: onChanged,
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Password",
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
