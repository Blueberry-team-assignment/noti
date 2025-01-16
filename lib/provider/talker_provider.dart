import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Talker Provider for DI
final talkerProvider = Provider<Talker>((ref) {
  final talker = TalkerFlutter.init(
    settings: TalkerSettings(
      colors: {
        // TalkerLogType.verbose.key: AnsiPen()..yellow(),
      },
    ),
  );
  talker.verbose('Talker initialized');
  return talker;
});
