import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_in_state.freezed.dart';

@freezed
class LogInState with _$LogInState {
  factory LogInState({
    @Default("") String email,
    @Default("") String pw,
  }) = _LogInState;
}
