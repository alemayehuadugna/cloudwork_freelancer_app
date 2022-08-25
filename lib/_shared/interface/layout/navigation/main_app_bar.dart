import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../bloc/setting/desktop_nav_cubit.dart';
import '../widgets/widgets.dart';

class MainAppBar extends AppBar implements PreferredSizeWidget {
  MainAppBar({Key? key, required BuildContext context})
      : super(
          key: key,
          elevation: 2,
          leading: ResponsiveWrapper.of(context).isDesktop
              ? BlocBuilder<DesktopSideNavCubit, bool>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        BlocProvider.of<DesktopSideNavCubit>(context)
                            .changeSideNavState();
                      },
                      icon: state
                          ? const Icon(
                              Icons.menu_open_sharp,
                            )
                          : const Icon(
                              Icons.menu_sharp,
                            ),
                    );
                  },
                )
              : null,
          actions: [
            const SizedBox(
              width: 10,
            ),
            const ProfilePopupMenu(),
            const SizedBox(
              width: 20,
            ),
          ],
        );
}
