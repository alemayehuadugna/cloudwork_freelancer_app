
import 'package:CloudWork_Freelancer/modules/bid/views/bid_view/pages/bid_list_page.dart';
import 'package:CloudWork_Freelancer/modules/bid/views/bid_wrapper_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_core/router/go_routes.dart';
import '../../_shared/interface/layout/layout_page.dart';
import '../../_shared/interface/layout/navigation/nav_items.dart';

const String bidRouteName = 'bid';

// const fadeTransitionKey = ValueKey<String>('Fade Transition Page Key');
// const layoutPageKey = ValueKey<String>('Layout Page Key');

final bidRoutes = [
  GoRoute(
    name: bidRouteName,
    path: '/bids',
    redirect: (_) => '/bids/bid',
  ),
  GoRoute(
    path: '/bids/:kind(bid|ongoing|completed|canceled)',
    pageBuilder: (context, state) => FadeTransitionPage(
        key: layoutKey,
      // key: fadeTransitionKey,
      child: LayoutPage(
        selectedTab: NavigationTab.bids,
        child: BidWrapperPage(
          child: BidListPage(
            kind: state.params['kind']!,
          ),
        ),
      ),
    ),
  ),

];
