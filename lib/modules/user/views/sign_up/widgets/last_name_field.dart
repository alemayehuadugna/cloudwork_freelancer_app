import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LastName extends StatelessWidget {
  LastName({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;
  final lastNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Last Name is required'),
    MinLengthValidator(
      3,
      errorText: 'Last Name must be at least 3 character long',
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: lastNameValidator,
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Last Name",
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
