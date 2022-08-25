import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DialogBottomActions extends StatelessWidget {
  const DialogBottomActions({
    Key? key,
    required this.onSave,
    this.label,
  }) : super(key: key);

  final void Function() onSave;
  final String? label;

  @override
  Widget build(BuildContext context) {
    bool isLargerThanMobile =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    return Align(
      alignment: isLargerThanMobile ? Alignment.bottomRight : Alignment.center,
      child: SizedBox(
        width: isLargerThanMobile ? 300 : MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      isLargerThanMobile
                          ? const Size(double.infinity, 50)
                          : const Size(double.infinity, 50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text(
                    "Cancel",
                  )),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    isLargerThanMobile
                        ? const Size(double.infinity, 50)
                        : const Size(double.infinity, 50),
                  ),
                ),
                onPressed: () {
                  onSave();
                },
                child: Text(label ?? " Save "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
