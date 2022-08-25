import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/icons/error_text.svg",
          height: 320,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
            ),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            "Back To Home".toUpperCase(),
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary
                ),
          ),
        )
      ],
    );
  }
}
