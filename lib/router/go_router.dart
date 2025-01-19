import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/auth/presentation/log_in_screen.dart';
import 'package:noti_flutter/features/auth/presentation/sign_up_screen.dart';
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
              const SignUpScreen(),
        ),
        GoRoute(
          path: 'log_in',
          builder: (BuildContext context, GoRouterState state) =>
              const LogInScreen(),
        ),
      ],
    ),
  ],
);
