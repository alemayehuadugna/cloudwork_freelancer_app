import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void showTopSnackBar({
  required Widget? title,
  required Widget content,
  required Widget? icon,
  required BuildContext context,
}) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 3),
    builder: (_, controller) {
      return Flash(
        controller: controller,
        margin: ResponsiveValue<EdgeInsets>(
          context,
          defaultValue: const EdgeInsets.all(10.0),
          valueWhen: [
            const Condition.equals(name: MOBILE, value: EdgeInsets.all(10.0)),
            Condition.largerThan(
              name: MOBILE,
              value: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.2,
                10,
                MediaQuery.of(context).size.width * 0.2,
                0,
              ),
            ),
            Condition.largerThan(
              name: TABLET,
              value: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.3,
                10,
                MediaQuery.of(context).size.width * 0.3,
                0,
              ),
            )
          ],
        ).value!,
        backgroundColor: Theme.of(context).colorScheme.background,
        barrierDismissible: true,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderColor: Theme.of(context).colorScheme.onBackground,
        brightness: Brightness.light,
        behavior: FlashBehavior.floating,
        position: FlashPosition.top,
        child: FlashBar(
          title: title,
          icon: icon,
          content: content,
          showProgressIndicator: false,
          primaryAction: TextButton(
            onPressed: () => controller.dismiss(),
            child: const Text(
              'DISMISS',
              style: TextStyle(color: Colors.amber),
            ),
          ),
        ),
      );
    },
  );
}
