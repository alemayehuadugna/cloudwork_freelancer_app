import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CloudworkName extends StatelessWidget {
  const CloudworkName({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Cloud',
            style: GoogleFonts.bodoniModa(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          TextSpan(
            text: 'Work',
            style: GoogleFonts.bodoniModa(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
        ],
      ),
    );
  }
}
