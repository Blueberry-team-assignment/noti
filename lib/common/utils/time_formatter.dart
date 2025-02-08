// 시간 관련한 데이터를 화면에 표시하기 위한 형식으로 바꾸기 위해 필요한 메서드를
// 한곳에서 관리하기 위해 생성했습니다.
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


