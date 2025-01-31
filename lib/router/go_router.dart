import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/log_in/presentation/log_in_screen.dart';
import 'package:noti_flutter/features/flow/presentation/register_flow/register_flow_screen.dart';
import 'package:noti_flutter/features/sign_up/presentation/sign_up_screen.dart';
import 'package:noti_flutter/features/flow/presentation/flow_screen/flow_screen.dart';
import 'package:noti_flutter/widgets/bottom_navigation_bar_layout.dart';
import 'package:noti_flutter/features/flow/presentation/home/home_screen.dart';
import 'package:noti_flutter/features/flow/presentation/my_page/my_page_screen.dart';
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
              NoTransitionPage(
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
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: SignUpScreen()),
        ),
        GoRoute(
          path: '/log_in',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: LogInScreen()),
        ),
        GoRoute(
          path: '/flow_register',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: RegisterFlowScreen()),
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
