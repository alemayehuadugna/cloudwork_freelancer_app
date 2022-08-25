import 'package:CloudWork_Freelancer/_shared/interface/layout/widgets/cloudwork_icon_icons.dart';
import 'package:flutter/material.dart';

import 'adaptive_navigation.dart';

enum NavigationTab {
  home,
  jobs,
  bids,
  chat,
  alerts,
  // bookmarks,
  wallet,
  reviews,
  // portfolios,
  settings
}

final navItems = <AdaptiveDestination>[
  AdaptiveDestination(
    title: 'Home',
    icon: CloudworkIcon.cloudwork_icon,
  ),
  AdaptiveDestination(
    title: 'Jobs',
    icon: Icons.work,
  ),
  AdaptiveDestination(
    title: 'Bids',
    icon: Icons.handshake,
  ),
  AdaptiveDestination(
    title: 'Chat',
    icon: Icons.chat,
  ),
  AdaptiveDestination(
    title: 'Alerts',
    icon: Icons.notifications,
  ),
  // AdaptiveDestination(
  //   title: 'Bookmark',
  //   icon: Icons.bookmark
  // ),
  AdaptiveDestination(
    title: 'Wallet',
    icon: Icons.account_balance_wallet
  ),
  AdaptiveDestination(
    title: 'Reviews',
    icon: Icons.rate_review,
  ),
  // AdaptiveDestination(
  //   title: 'Portfolios',
  //   icon: Icons.view_quilt
  // ),
  AdaptiveDestination(
    title: 'Settings',
    icon: Icons.settings,
  ),
];
