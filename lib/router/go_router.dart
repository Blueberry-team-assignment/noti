import 'package:go_router/go_router.dart';
import 'package:noti_flutter/timer_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TimerScreen(),
    ),
  ],
);
