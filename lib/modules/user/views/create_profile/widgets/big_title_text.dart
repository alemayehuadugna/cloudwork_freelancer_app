import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BigTitleText extends StatelessWidget {
  const BigTitleText({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: ResponsiveValue<double>(
            context,
            defaultValue: 32,
            valueWhen: const [
              Condition.equals(
                name: TABLET,
                value: 36,
              ),
              Condition.equals(
                name: DESKTOP,
                value: 44,
              ),
            ],
          ).value,
        ),
      ),
    );
  }
}
