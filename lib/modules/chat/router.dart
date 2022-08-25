import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../_core/router/go_routes.dart';
import '../../_shared/interface/layout/layout_page.dart';
import '../../_shared/interface/layout/navigation/navigation.dart';
import 'views/pages/chat_page.dart';

const String chatRouteName = 'chat';
const String conversationRouteName = 'conversation';

final List<GoRoute> chatRoutes = [
  GoRoute(
      name: chatRouteName,
      path: '/chat',
      pageBuilder: (context, state) => FadeTransitionPage(
            key: fadeTransitionKey,
            child: LayoutPage(
              selectedTab: NavigationTab.chat,
              child: ResponsiveWrapper.of(context).isMobile
                  ? const ChatMobilePage()
                  : const ChatPage(),
            ),
          ),
      routes: [
        GoRoute(
          name: conversationRouteName,
          path: ':conversationId',
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: ResponsiveWrapper.of(context).isMobile
                ? const MessageMobilePage()
                : const LayoutPage(
                    selectedTab: NavigationTab.chat,
                    child: ChatPage(),
                  ),
          ),
        ),
      ]),
];
