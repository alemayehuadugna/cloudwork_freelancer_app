import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../router.dart';
import '../widgets/widgets.dart';

class CreateProfileStartPage extends StatelessWidget {
  const CreateProfileStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isMobile) const LinearProgressIndicator(value: 0),
          const _BuildBody(),
          if (!isMobile) const LinearProgressIndicator(value: 0),
          CreateProfileFooter(
            nextRouteTitle: "Next, Write Your Expertise",
            onPressed: () {
              context.pushNamed(createProfileExpertiseRouteName);
            },
          )
        ],
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveWrapper.of(context).isDesktop;
    bool isTablet = ResponsiveWrapper.of(context).isTablet;
    return Expanded(
      child: SizedBox(
        width: isDesktop ? 900 : double.infinity,
        child: Padding(
          padding: isTablet
              ? const EdgeInsets.fromLTRB(60, 0, 60, 0)
              : const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 350,
                child: ClipRRect(
                  child: SvgPicture.asset("assets/icons/fill_form.svg"),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              const BigTitleText(
                  title:
                      'Clients Would Like to See Your Profile. So Let\'s Start Creating Your Profile.'),
            ],
          ),
        ),
      ),
    );
  }
}
