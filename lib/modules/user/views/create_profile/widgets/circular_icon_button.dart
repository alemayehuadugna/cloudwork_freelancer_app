import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.padding,
  }) : super(key: key);

  final Function onPressed;
  final IconData icon;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      child: Icon(icon),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
        // <-- Button color
      ),
    );
  }
}
