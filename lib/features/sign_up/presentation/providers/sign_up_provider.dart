import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/dto/sign_up_dto.dart';
import 'package:noti_flutter/features/sign_up/domain/sign_up_service.dart';
import 'package:noti_flutter/talker.dart';

final signUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  final signUpService = ref.watch(signUpServiceProvider);
  return SignUpNotifier(signUpService);
});

class SignUpNotifier extends StateNotifier<SignUpState> {
  final SignUpService _signUpService;

  SignUpNotifier(
    this._signUpService,
  ) : super(SignUpState());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      setLoading(true);

      final authUser = await _signUpService.signUpAndSave(
        signUpDto: SignUpDto(
          isAuthUser: true,
          name: name,
          password: password,
          email: email,
        ),
      );

      talkerInfo(
          "signUpProvider", "authUser signed up : ${authUser.toString()}");

      setLoading(false);
    } catch (e) {
      setLoading(false);
      rethrow;
    }
  }

  void setLoading(bool loading) {
    state = SignUpState(isLoading: loading);
  }
}

class SignUpState {
  SignUpDto? signUpDto;
  bool isLoading;

  SignUpState({
    this.signUpDto,
    this.isLoading = false,
  });
}
