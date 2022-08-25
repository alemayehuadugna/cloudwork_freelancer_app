import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CreateProfileFooter extends StatelessWidget {
  const CreateProfileFooter({
    Key? key,
    required this.nextRouteTitle,
    required this.onPressed,
    this.buttonContent,
  }) : super(key: key);

  final String nextRouteTitle;
  final void Function()? onPressed;
  final Widget? buttonContent;

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    bool isStart = GoRouter.of(context).location == '/create-profile';
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      padding: isMobile
          ? const EdgeInsets.all(0)
          : const EdgeInsets.fromLTRB(80, 20, 80, 20),
      child: Row(
        mainAxisAlignment: isStart
            ? MainAxisAlignment.end
            : isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
        children: [
          if (!isStart)
            if (!isMobile)
              SizedBox(
                height: 40,
                width: 96,
                child: OutlinedButton(
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size.fromHeight(40)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Back"),
                ),
              ),
          if (!isMobile)
            SizedBox(
              height: 56,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                onPressed: onPressed,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isStart
                      ? const Text('Start Creating Your Profile')
                      : buttonContent ?? Text(nextRouteTitle),
                ),
              ),
            ),
          if (isMobile)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size.fromHeight(52)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isStart
                        ? const Text('Start Creating Your Profile')
                        : buttonContent ?? Text(nextRouteTitle),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
