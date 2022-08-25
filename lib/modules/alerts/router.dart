import 'package:go_router/go_router.dart';

import '../../_core/router/go_routes.dart';
import '../../_shared/interface/layout/layout_page.dart';
import '../../_shared/interface/layout/navigation/navigation.dart';
import 'views/pages/alert_page.dart';

const String alertRouteName = 'alerts';

final List<GoRoute> alertRoutes = [
  GoRoute(
    name: alertRouteName,
    path: '/alerts',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: fadeTransitionKey,
      child: const LayoutPage(
        selectedTab: NavigationTab.alerts,
        child: AlertPage(),
      ),
    ),
  )
];
