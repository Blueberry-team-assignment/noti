import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/log_in/presentation/log_in_screen.dart';
import 'package:noti_flutter/features/sign_up/presentation/sign_up_screen.dart';
import 'package:noti_flutter/features/flow/flow_screen.dart';
import 'package:noti_flutter/presentation/ui/test_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const TestScreen(),
      routes: [
        GoRoute(
          path: 'sign_up',
          builder: (BuildContext context, GoRouterState state) =>
              SignUpScreen(),
        ),
        GoRoute(
          path: 'log_in',
          builder: (BuildContext context, GoRouterState state) =>
              const LogInScreen(),
        ),
        GoRoute(
          path: 'flow',
          builder: (BuildContext context, GoRouterState state) =>
              const FlowScreen(),
        ),
      ],
    ),
  ],
);
