import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/data/dto/sign_up_dto.dart';
import 'package:noti_flutter/features/auth/domain/sign_up_service.dart';
import 'package:noti_flutter/features/auth/presentation/providers/states/sign_up_state.dart';
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

  Future<void> signUp() async {
    state = state.copyWith(isLoading: true);
    try {
      final authUser = await _signUpService.execute(
          signUpDto: SignUpDto(
        isAuthUser: true,
        name: state.name,
        password: state.password,
        email: state.email,
      ));
      talkerInfo(
          "signUpProvider", "authUser signed up : ${authUser.toString()}");
    } catch (e) {
      rethrow;
    }
    state = state.copyWith(isLoading: false);
  }

  void saveNameField({required String name}) {
    state = state.copyWith(name: name);
  }

  void savePasswordField({required String password}) {
    state = state.copyWith(password: password);
  }

  void saveEmailField({required String email}) {
    state = state.copyWith(email: email);
  }
}
