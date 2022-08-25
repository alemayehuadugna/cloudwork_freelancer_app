import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_shared/interface/layout/navigation/nav_items.dart';
import '../../modules/alerts/router.dart';
import '../../modules/bid/router.dart';
import '../../modules/chat/router.dart';
import '../../modules/dashboard/router.dart';
import '../../modules/job/router.dart';
import '../../modules/payments/router.dart';
import '../../modules/portfolio/router.dart';
import '../../modules/review/router.dart';
import '../../modules/setting/router.dart';

void navRoutes(int index, BuildContext context) {
  switch (NavigationTab.values[index]) {
    case NavigationTab.home:
      context.goNamed(homeRouteName);
      break;
    case NavigationTab.alerts:
      context.goNamed(alertRouteName);
      break;
    case NavigationTab.bids:
      context.goNamed(bidRouteName);
      break;
    // case NavigationTab.bookmarks:
    //   context.goNamed(bookmarkRouteName);
    //   break;
    case NavigationTab.chat:
      context.goNamed(chatRouteName);
      break;
    case NavigationTab.jobs:
      context.goNamed(jobRouteName);
      break;
    case NavigationTab.wallet:
      context.goNamed(paymentRouteName);
      break;
    // case NavigationTab.portfolios:
    //   context.goNamed(listPortfolioRouteName);
    //   break;
    case NavigationTab.reviews:
      context.goNamed(reviewRouteName);
      break;
    case NavigationTab.settings:
      context.goNamed(settingRouteName);
      break;
    default:
  }
}
