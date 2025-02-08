import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*  FlutterLocalNotificationsPlugin 인스턴스를 전역으로 제공하기 위한 프로바이더.
    플로우의 집중/휴식시간 타이머가 종료되었을 때 푸쉬 알림 요청을 보내는 역할을 합니다.
 */
final localNotificationProvider = Provider<FlutterLocalNotificationsPlugin>(
  (ref) {
    final plugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings(
        "@mipmap/ic_launcher"); // 알림에 표시되는 아이콘을 앱 아이콘으로 사용하겠다.
    const ios = DarwinInitializationSettings(
      // permission_handler를 따로 사용하기 때문에 권한 요청 모두 false로 합니다.
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const settings = InitializationSettings(android: android, iOS: ios);
    plugin.initialize(settings);
    return plugin;
  },
);
