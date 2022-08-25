import 'package:flutter/material.dart';

class TextWithOpacity extends StatelessWidget {
  const TextWithOpacity({
    Key? key,
    required this.opacity,
    required this.text,
  }) : super(key: key);

  final double opacity;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Opacity(opacity: opacity, child: Text(text)),
    );
  }
}