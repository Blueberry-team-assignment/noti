class TimeFormatter {
  // seconds를 String으로 변환하는 메서드
  static Map<String, String> formatSecondsToString(int? seconds) {
  if (seconds == null) return {};

  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;
  final remainingSeconds = seconds % 60;

  return {
    if (hours > 0) "hours": hours.toString(),
    "minutes": minutes.toString().padLeft(2, "0"),
    "seconds": remainingSeconds.toString().padLeft(2, "0"),
    "minutesWithoutPadLeft": minutes.toString(),
  };
}
}


