import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../bloc/setting/desktop_nav_cubit.dart';
import 'widgets.dart';

class SideDrawerHeader extends StatelessWidget {
  const SideDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DesktopSideNavCubit, bool>(
      builder: (context, state) {
        return Card(
          margin: EdgeInsets.zero,
          child: SizedBox(
            height: 57,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CloudworkLogo(height: 40),
                if (state || !ResponsiveWrapper.of(context).isDesktop)
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const CloudworkName(fontSize: 18),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
