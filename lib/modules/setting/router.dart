import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../_core/router/go_routes.dart';
import '../../_shared/interface/layout/layout_page.dart';
import '../../_shared/interface/layout/navigation/nav_items.dart';
import '../user/router.dart';
import '../user/views/change_password/pages/change_password_page.dart';
import '../user/views/delete_account/pages/delete_account_page.dart';
import '../user/views/edit_profile/pages/edit_profile_page.dart';
import '../user/views/view_profile/pages/profile_page.dart';
import 'views/give_feedback/pages/give_feedback_page.dart';
import 'views/settings_page.dart';

const String settingRouteName = 'settings';
const String editProfileRouteName = 'edit-profile';
const String changePasswordRouteName = 'change-password';
const String giveFeedbackRouteName = 'give-feedback';
const String deleteAccountRouteName = 'delete-account';

final List<GoRoute> settingRoutes = [
  GoRoute(
      name: settingRouteName,
      path: '/settings',
      pageBuilder: (context, state) => FadeTransitionPage(
            key: fadeTransitionKey,
            child: LayoutPage(
              key: layoutKey,
              selectedTab: NavigationTab.settings,
              child: ResponsiveWrapper.of(context).isMobile
                  ? const SettingMobilePage()
                  : const SettingPage(),
            ),
          ),
      routes: [
        GoRoute(
          name: viewProfileRouteName,
          path: 'my-profile',
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LayoutPage(
              key: layoutKey,
              selectedTab: NavigationTab.settings,
              child: ResponsiveWrapper.of(context).isMobile
                  ? const ViewSettingMobile(body: ViewProfilePage())
                  : const ViewSetting(body: ViewProfilePage()),
            ),
          ),
        ),
        GoRoute(
          name: editProfileRouteName,
          path: 'edit-profile',
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LayoutPage(
              key: layoutKey,
              selectedTab: NavigationTab.settings,
              child: ResponsiveWrapper.of(context).isMobile
                  ? const ViewSettingMobile(body: EditProfilePage())
                  : const ViewSetting(body: EditProfilePage()),
            ),
          ),
        ),
        GoRoute(
          name: changePasswordRouteName,
          path: 'change-password',
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LayoutPage(
              key: layoutKey,
              selectedTab: NavigationTab.settings,
              child: ResponsiveWrapper.of(context).isMobile
                  ? ViewSettingMobile(body: ChangePasswordPage())
                  : ViewSetting(body: ChangePasswordPage()),
            ),
          ),
        ),
        GoRoute(
          name: deleteAccountRouteName,
          path: 'delete-account',
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LayoutPage(
              key: layoutKey,
              selectedTab: NavigationTab.settings,
              child: ResponsiveWrapper.of(context).isMobile
                  ? ViewSettingMobile(body: DeleteAccountPage())
                  : ViewSetting(body: DeleteAccountPage()),
            ),
          ),
        ),
        GoRoute(
          name: giveFeedbackRouteName,
          path: 'give-feedback',
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LayoutPage(
              key: layoutKey,
              selectedTab: NavigationTab.settings,
              child: ResponsiveWrapper.of(context).isMobile
                  ? const ViewSettingMobile(body: GiveFeedbackPage())
                  : const ViewSetting(body: GiveFeedbackPage()),
            ),
          ),
        ),
      ]),
];
