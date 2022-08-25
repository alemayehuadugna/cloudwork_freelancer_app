import 'package:CloudWork_Freelancer/modules/job/views/job_list/pages/job_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_core/router/go_routes.dart';
import '../../_shared/interface/layout/layout_page.dart';
import '../../_shared/interface/layout/navigation/nav_items.dart';
import 'views/job_detail/pages/job_detail_page.dart';
import 'views/job_wrapper_page.dart';

const String jobRouteName = 'job';
const String jobDetailRouteName = 'job-details';
const layoutPageKey = ValueKey<String>('Layout Page Key');
const fadeTransitionKey = ValueKey<String>('Fade Transition Page Key');

final List<GoRoute> jobRoutes = [
        GoRoute(
        name: jobRouteName,
        path: '/jobs',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: fadeTransitionKey,
          child: const LayoutPage(
            key: layoutPageKey,
            selectedTab: NavigationTab.jobs,
            child: JobWrapperPage(child: JobListPage()),
          ),
        ),
        routes: [
          GoRoute(
            name: jobDetailRouteName,
            path: 'details/:id',
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: LayoutPage(
                key: layoutPageKey,
                selectedTab: NavigationTab.jobs,
                child: JobWrapperPage(
                  child: JobDetailPage(
                    id: state.params['id'],
                  ),
                ),
                hideBottomAndTopBarOnMobile: true,
              ),
            ),
          ),
        ],
      ),
];
