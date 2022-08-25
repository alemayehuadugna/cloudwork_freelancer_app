import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../_core/router/nav_routes.dart';
import '../../../modules/alerts/views/bloc/new_alert_bloc/new_alert_bloc.dart';
import '../widgets/show_top_flash.dart';
import 'navigation/navigation.dart';
import 'widgets/widgets.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({
    Key? key,
    required this.selectedTab,
    required this.child,
    this.hideBottomAndTopBarOnMobile,
  }) : super(key: key);

  final NavigationTab selectedTab;
  final Widget child;
  final bool? hideBottomAndTopBarOnMobile;

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    bool isHidden = hideBottomAndTopBarOnMobile == null
        ? false
        : hideBottomAndTopBarOnMobile!;

    return BlocListener<NewAlertBloc, NewAlertState>(
      listener: (context, state) {
        if (state is NewAlertLoaded) {
          showTopSnackBar(
            title: Text(state.alert.title),
            content: Text(
              state.alert.message,
              overflow: TextOverflow.ellipsis,
            ),
            icon: const Icon(Icons.notifications_active_rounded),
            context: context,
          );
        }
      },
      child: (isHidden && isMobile)
          ? Scaffold(
              key: key,
              body: child,
            )
          : Scaffold(
              body: AdaptiveNavigation(
                  key: key,
                  drawerHeader: const SideDrawerHeader(),
                  includeBaseDestinationsInMenu: false,
                  appBar: MainAppBar(context: context),
                  body: child,
                  selectedIndex: selectedTab.index,
                  destinations: navItems,
                  onDestinationSelected: (index) {
                    navRoutes(index, context);
                  }),
            ),
    );
  }
}
