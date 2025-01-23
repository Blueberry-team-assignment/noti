import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/log_in/presentation/log_in_screen.dart';
import 'package:noti_flutter/features/sign_up/presentation/sign_up_screen.dart';
import 'package:noti_flutter/features/flow/flow_screen.dart';
import 'package:noti_flutter/widgets/bottom_navigation_bar_layout.dart';
import 'package:noti_flutter/features/home/home_screen.dart';
import 'package:noti_flutter/features/my_page/my_page_screen.dart';
import 'package:noti_flutter/widgets/default_app_bar_layout.dart';

final router = GoRouter(
  initialLocation: '/log_in',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final title = routeTitles[state.matchedLocation];
        return BottomNavigationBarLayout(
          title: title,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/flow',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: FlowScreen(),
          ),
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/my_page',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: MyPageScreen(),
          ),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) {
        final title = routeTitles[state.matchedLocation];
        return DefaultAppBarLayout(
          title: title,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/sign_up',
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: '/log_in',
          builder: (context, state) => const LogInScreen(),
        ),
      ],
    ),
  ],
);

const Map<String, String> routeTitles = {
  '/flow': 'Flow',
  '/home': 'Home',
  '/my_page': 'My Page',
  '/sign_up': 'Sign Up',
  '/log_in': 'Log In',
};
