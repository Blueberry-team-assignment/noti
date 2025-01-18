import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider = Provider<SharedPreferencesAsync>((ref) {
  final sharedPreferences = SharedPreferencesAsync();
  return sharedPreferences;
});
