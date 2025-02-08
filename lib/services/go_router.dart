import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/log_in/presentation/log_in_screen.dart';
import 'package:noti_flutter/features/flow/presentation/register_flow/register_flow_screen.dart';
import 'package:noti_flutter/features/sign_up/presentation/sign_up_screen.dart';
import 'package:noti_flutter/features/flow/presentation/flow_screen/flow_timer_screen.dart';
import 'package:noti_flutter/common/widgets/bottom_navigation_bar_layout.dart';
import 'package:noti_flutter/features/flow/presentation/home/home_screen.dart';
import 'package:noti_flutter/features/flow/presentation/my_page/my_page_screen.dart';
import 'package:noti_flutter/common/widgets/default_app_bar_layout.dart';

/*  router를 처리하기 위한 GoRouter인스턴스 초기화.
    현재 서비스에서 꼭 필요한 것은 아니지만, 프로덕트에서 리다이렉트나 사용자의 앱의 특정 화면으로 보내는 경우에 많이 사용하기 때문에 연습해보고 싶어서 넣었습니다.
 */
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
        GoRoute(
          path: '/flow',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: FlowTimerScreen(),
          ),
        ),
      ],
    ),
  ],
);

const Map<String, String> routeTitles = {
  '/flow': '플로우',
  '/home': '플로우 목록',
  '/my_page': '마이 페이지',
  '/sign_up': '회원가입',
  '/log_in': '로그인',
  '/flow_register': "플로우 등록"
};
