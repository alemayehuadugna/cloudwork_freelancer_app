
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CloudworkLogo extends StatelessWidget {
  const CloudworkLogo({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/cloudwork_logo.svg",
      height: height,
    );
  }
}