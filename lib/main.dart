import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/firebase_options.dart';
import 'package:noti_flutter/services/go_router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen();

  runApp(
    ProviderScope(
      observers: [
        TalkerRiverpodObserver(
          //talker: talker,
          settings: const TalkerRiverpodLoggerSettings(
            printProviderDisposed: true,
          ),
        ),
      ],
      child: const NotiFlutter(),
    ),
  );
}

class NotiFlutter extends ConsumerStatefulWidget {
  const NotiFlutter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotiFlutterState();
}

class _NotiFlutterState extends ConsumerState<NotiFlutter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 알림 권한 요청
    _permissionWithNotification();
  }

  // IOS인 경우 권한을 요청 받지 않는 상태라면 권한을 요청하고, 거부 또는 허용된 상태에서는 요청하지 않는다.
  // Android의 경우에는 33레벨 이전에서는 권한을 묻지 않고, 33레벨 이상 부터는 권한이 없는 경우 또는 거부된 상태인 경우 최대 2번까지 요청한다.
  void _permissionWithNotification() async {
    if (await Permission.notification.isDenied &&
        !await Permission.notification.isPermanentlyDenied) {
      await [Permission.notification].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: const Color(0xFFFAFAFA),
    );
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
