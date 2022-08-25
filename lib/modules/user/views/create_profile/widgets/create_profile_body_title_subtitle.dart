import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'widgets.dart';

class CreateProfileBodyTitleSubtitle extends StatelessWidget {
  const CreateProfileBodyTitleSubtitle(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var isLargerThanMobile = ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    return SizedBox(
      width: isLargerThanMobile ? 900 : double.infinity,
      child: Padding(
        padding: isLargerThanMobile
            ? const EdgeInsets.fromLTRB(60, 30, 60, 30)
            : const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigTitleText(title: title),
            SizedBox(
              width: isLargerThanMobile ? 900 * 0.6 : double.infinity,
              child: SubTitleText(
                subtitle: subtitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
