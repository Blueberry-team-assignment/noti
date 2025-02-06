import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localNotificationProvider = Provider<FlutterLocalNotificationsPlugin>(
  (ref) {
    final plugin = FlutterLocalNotificationsPlugin();
    const android =
        AndroidInitializationSettings("@mipmap/ic_launcher"); // 알림 발송에 앱 아이콘 사용
    const ios = DarwinInitializationSettings(
      // permission_handler를 따로 사용하기 때문에 권한 요청 모두 false
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const settings = InitializationSettings(android: android, iOS: ios);
    plugin.initialize(settings);
    return plugin;
  },
);
