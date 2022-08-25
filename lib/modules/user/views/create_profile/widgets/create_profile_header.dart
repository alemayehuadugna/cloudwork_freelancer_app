import 'package:flutter/material.dart';

class CreateProfileHeader extends StatelessWidget {
  const CreateProfileHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              icon: const Icon(Icons.close),
              splashRadius: 25,
              padding: EdgeInsets.zero,
            )
          ],
        ),
      ),
    );
  }
}
