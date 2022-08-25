import 'package:go_router/go_router.dart';

import '../../_core/router/go_routes.dart';
import '../../_shared/interface/layout/layout_page.dart';
import '../../_shared/interface/layout/navigation/navigation.dart';
import 'views/pages/review_page.dart';

const String reviewRouteName = 'review';

final List<GoRoute> reviewRoutes = [
  GoRoute(
    name: reviewRouteName,
    path: '/reviews',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: fadeTransitionKey,
      child: const LayoutPage(
        selectedTab: NavigationTab.reviews,
        child: ReviewPage(),
      ),
    ),
  )
];
