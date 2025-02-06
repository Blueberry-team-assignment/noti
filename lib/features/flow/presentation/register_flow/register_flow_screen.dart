import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/dto/flow_dto.dart';
import 'package:noti_flutter/features/flow/presentation/home/flow_list_provider.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';
import 'package:noti_flutter/features/flow/presentation/register_flow/register_flow_provider.dart';
import 'package:noti_flutter/talker.dart';

class RegisterFlowScreen extends ConsumerStatefulWidget {
  const RegisterFlowScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterFlowScreenState();
}

class _RegisterFlowScreenState extends ConsumerState<RegisterFlowScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _focusTimeController = TextEditingController();
  final TextEditingController _restTimeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _flowNameController = TextEditingController();

  @override
  void dispose() {
    _focusTimeController.dispose();
    _restTimeController.dispose();
    _descController.dispose();
    _flowNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);
    final registerFLowState = ref.watch(registerFlowProvider);
    final registerFLowNotifier = ref.watch(registerFlowProvider.notifier);

    return Form(
      key: formKey,
      child: Column(
        spacing: 20,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "플로우 이름",
              hintText: "등록하실 플로우의 이름을 입력해주세요",
            ),
            controller: _flowNameController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return "플로우 이름을 입력해주세요";
              }
              if (text.length < 2 || text.length > 16) {
                return "플로우 이름은 2글자 이상 16글자 이하여야 합니다.";
              }
              // 영어, 한글, 숫자만 허용하는 정규식
              final allowedCharactersRegex = RegExp(r'^[a-zA-Z가-힣0-9]+$');
              if (!allowedCharactersRegex.hasMatch(text)) {
                return "플로우 이름은 영어, 한글, 숫자만 입력 가능합니다.";
              }
              return null;
            },
          ),
          Row(
            spacing: 50,
            children: [
              Expanded(
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  decoration: const InputDecoration(
                    suffixText: "분",
                    labelText: "집중 시간",
                  ),
                  controller: _focusTimeController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "시간(분)을 입력해주세요.";
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  decoration: const InputDecoration(
                    suffixText: "분",
                    labelText: "휴식 시간",
                  ),
                  controller: _restTimeController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "시간(분)을 입력해주세요.";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "메모",
              hintText: "무엇이든 기록하세요",
            ),
            controller: _descController,
            validator: (text) {
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                if (formKey.currentState!.validate()) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('플로우를 등록하고 있어요...')),
                    );
                  }

                  await registerFLowNotifier.createFlow(
                    uid: userState.user?.uid,
                    flowDto: FlowDto(
                      name: _flowNameController.text,
                      focusTime: Duration(
                          minutes: int.parse(_focusTimeController.text)),
                      restTime: Duration(
                          minutes: int.parse(_restTimeController.text)),
                      desc: _descController.text,
                    ),
                  );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('플로우가 등록되었습니다'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    if (context.mounted) {
                      ref.read(flowListProvider.notifier).loadFlowList();
                      context.go("/home");
                    }
                  });
                }
              } catch (e) {
                talkerInfo("register_flow_screen", e.toString());
                if (context.mounted) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 20),
                      action: SnackBarAction(
                        label: '닫기',
                        textColor: Colors.white,
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                }
              }
            },
            child: registerFLowState.isLoading
                ? const CircularProgressIndicator()
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
