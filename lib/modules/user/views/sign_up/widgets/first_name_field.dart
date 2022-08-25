import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FirstName extends StatelessWidget {
  FirstName({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  final firstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'First Name is required'),
    MinLengthValidator(
      3,
      errorText: 'First Name must be at least 3 character long',
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: firstNameValidator,
      decoration: const InputDecoration(
        isDense: true,
        labelText: "First Name",
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
