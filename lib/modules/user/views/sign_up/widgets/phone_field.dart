import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PhoneField extends StatelessWidget {
  PhoneField({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;
  final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone is required'),
    PhoneValidator(errorText: 'Enter a valid phone number'),
  ]);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: phoneValidator,
      // initialValue: "+251",
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Phone",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      keyboardType: TextInputType.phone,
    );
  }
}

class PhoneValidator extends TextFieldValidator {
  PhoneValidator({required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(String? value) {
    return hasMatch(r'^([+]251)?(9[0-9]{8})$', value!);
  }
}
