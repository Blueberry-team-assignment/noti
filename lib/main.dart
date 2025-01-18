import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/presentation/test_screen.dart';
import 'package:noti_flutter/firebase_options.dart';

import 'package:noti_flutter/talker.dart';
import 'package:noti_flutter/timer_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
            talker: talker,
            settings: const TalkerRiverpodLoggerSettings(
              printProviderDisposed: true,
            )),
      ],
      child: const NotiFlutter(),
    ),
  );
}

class NotiFlutter extends ConsumerWidget {
  const NotiFlutter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: Colors.blue,
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: const TestScreen(),
    );
  }
}
