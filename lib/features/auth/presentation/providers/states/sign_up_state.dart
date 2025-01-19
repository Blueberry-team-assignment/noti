import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  factory SignUpState({
    @Default("") String name,
    @Default("") String email,
    @Default("") String password,
  }) = _SignUpState;
}
