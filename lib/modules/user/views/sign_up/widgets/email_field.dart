import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EmailField extends StatelessWidget {
  EmailField({
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
        isDense: true,
        labelText: "Email",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
