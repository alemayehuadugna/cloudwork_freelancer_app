import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../_shared/interface/pages/error/error_page.dart';
import '../../_shared/interface/pages/loading/pages/loading_page.dart';
import '../../modules/alerts/router.dart';
import '../../modules/bid/router.dart';
import '../../modules/bookmark/router.dart';
import '../../modules/chat/router.dart';
import '../../modules/dashboard/router.dart';
import '../../modules/job/router.dart';
import '../../modules/landing/views/pages/landing_page.dart';
import '../../modules/payments/router.dart';
import '../../modules/portfolio/router.dart';
import '../../modules/review/router.dart';
import '../../modules/setting/router.dart';
import '../../modules/user/router.dart';

const fadeTransitionKey = ValueKey<String>('Layout Scaffold');
const layoutKey = ValueKey<String>('Layout Key');

const String rootRouteName = 'root';
const String postDetailsRouteName = 'post-details';
const String loadingRouteName = 'loading';
const String landingRouteName = 'landing';

class GoAppRouter {
  final AuthBloc authBloc;

  GoAppRouter(this.authBloc);

  late final router = GoRouter(
    routes: [
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (_) => '/landing',
      ),
      GoRoute(
        name: loadingRouteName,
        path: '/loading',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoadingPage(),
        ),
      ),
      GoRoute(
        name: landingRouteName,
        path: '/landing',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const LandingPage(),
        ),
      ),
      ...homeRoutes,
      ...alertRoutes,
      ...bidRoutes,
      ...bookmarkRoutes,
      ...chatRoutes,
      ...jobRoutes,
      ...paymentRoutes,
      ...portfolioRoutes,
      ...reviewRoutes,
      ...userRoutes,
      ...settingRoutes,
    ],
    errorPageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    debugLogDiagnostics: true,
    redirect: _guard,
  );

  final unAuthScope = [
    '/login',
    '/create-account',
    '/forget-password',
    '/landing',
  ];

  final createProfileScope = [
    '/create-profile',
    '/create-profile/add-expertise',
    '/create-profile/add-experience',
    '/create-profile/add-education',
    '/create-profile/add-language',
    '/create-profile/add-skill',
    '/create-profile/add-bio',
    '/create-profile/add-area-of-work',
    '/create-profile/add-basic-profile',
    '/create-profile/check-profile',
  ];

  String? _guard(GoRouterState state) {
    // print("route subloc => ${state.subloc}");
    // final authLoading = authBloc.state is AuthLoading;
    // final isLoading = state.subloc == '/loading';
    // final loadingLoc = state.namedLocation(loadingRouteName);
    // if (authLoading) return isLoading ? null : loadingLoc;
    // print("authBloc.state => ${authBloc.state}");

    final verifying = state.subloc == '/verify';
    final isUnverified = authBloc.state is Unverified;
    final verifyLoc = state.namedLocation(verifyRouteName);
    if (isUnverified) return verifying ? null : verifyLoc;

    final completingProfile = createProfileScope.contains(state.subloc);
    final isIncompleteProfile = authBloc.state is InCompleteProfile;
    final createProfileLoc = state.namedLocation(createProfileRouteName);
    if (isIncompleteProfile) return completingProfile ? null : createProfileLoc;

    final isUnauthenticated = authBloc.state is Unauthenticated;
    final unAuthRoute = unAuthScope.contains(state.subloc);
    final loggingIn = state.subloc == '/login';
    final loginLoc = state.namedLocation(loginRouteName);
    if (isUnauthenticated && !loggingIn) return unAuthRoute ? null : loginLoc;

    final loggedIn = authBloc.state is Authenticated;
    final rootLoc = state.namedLocation(homeRouteName);
    if (loggedIn &&
        (loggingIn || unAuthRoute || verifying || completingProfile)) {
      return rootLoc;
    }
    return null;
  }
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
            key: key,
            transitionsBuilder: (c, animation, a2, child) => FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ),
            child: child);
  static final _curveTween = CurveTween(curve: Curves.easeIn);
}
