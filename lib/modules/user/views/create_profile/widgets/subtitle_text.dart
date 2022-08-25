import 'package:flutter/material.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({
    Key? key,
    required this.subtitle,
  }) : super(key: key);

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Opacity(
        opacity: 0.7,
        child: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
