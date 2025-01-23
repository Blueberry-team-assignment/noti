import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/log_in/presentation/log_in_screen.dart';
import 'package:noti_flutter/features/sign_up/presentation/sign_up_screen.dart';
import 'package:noti_flutter/features/flow/flow_screen.dart';
import 'package:noti_flutter/widgets/bottom_navigation_bar_layout.dart';
import 'package:noti_flutter/widgets/home_screen.dart';
import 'package:noti_flutter/features/my_page/my_page_screen.dart';

final router = GoRouter(
  initialLocation: '/log_in',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return BottomNavigationBarLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/flow',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: FlowScreen()),
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/my_page',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: MyPageScreen()),
        ),
      ],
    ),
    GoRoute(
      path: '/sign_up',
      builder: (BuildContext context, GoRouterState state) =>
          const SignUpScreen(),
    ),
    GoRoute(
      path: '/log_in',
      builder: (BuildContext context, GoRouterState state) =>
          const LogInScreen(),
    ),
  ],
);
