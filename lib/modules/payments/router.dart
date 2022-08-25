
import 'package:go_router/go_router.dart';

import '../../_core/router/go_routes.dart';
import '../../_shared/interface/layout/layout_page.dart';
import '../../_shared/interface/layout/navigation/nav_items.dart';
import 'views/pages/payment_page.dart';

const String paymentRouteName = 'payment';

final paymentRoutes = [
  GoRoute(
    name: paymentRouteName,
    path: '/payments',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: layoutKey,
      child: const LayoutPage(
        selectedTab: NavigationTab.wallet,
        child: PaymentPage(),
      ),
    ),
  ),
];
