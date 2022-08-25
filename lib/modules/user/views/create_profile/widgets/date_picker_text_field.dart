import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class DatePickerTextField extends StatelessWidget {
  const DatePickerTextField(
      {Key? key, this.controller, required this.label, required this.onTab})
      : super(key: key);

  final TextEditingController? controller;
  final String label;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.datetime,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9-]'))
      ],
      validator: MultiValidator([
        RequiredValidator(errorText: 'Select Date'),
        MaxLengthValidator(7, errorText: "Must be at most 7 characters")
      ]),
      decoration: InputDecoration(
        isDense: true,
        label: Text(label),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      onTap: () {
        onTab();
      },
    );
  }
}
