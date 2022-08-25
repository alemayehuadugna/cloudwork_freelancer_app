import 'package:flutter/material.dart';

class EditProfileErrorDisplay extends StatelessWidget {
  const EditProfileErrorDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Error Loading User Detail"),
    );
  }
}
