import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.backgroundColor,
  }) : super(key: key);

  final String title;
  final double amount;
  final Widget icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 60.0,
              height: 100.0,
              child: CircleAvatar(
                backgroundColor: backgroundColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Center(child: icon),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "$amount ETB",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
