import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EmailInput extends StatelessWidget {
  EmailInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address'),
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: emailValidator,
      controller: controller,
      decoration: const InputDecoration(
        isDense: false,
        labelText: "Email",
        suffixIcon: Icon(Icons.email),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
        ),
      ),
    );
  }
}
