import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    required this.validator,
    required this.label,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
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
    );
  }
}
