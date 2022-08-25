import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 6,
      maxLines: null,
      validator: RequiredValidator(errorText: 'Description required'),
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Description',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
