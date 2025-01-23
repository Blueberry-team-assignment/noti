import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/flow/flow_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowRepository = ref.watch(flowRepositoryProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("home"),
        ElevatedButton(
          onPressed: () {
            // flowRepository.createFlow(uid: uid, flowDto: flowDto),
          },
          child: const Text('flow 생성'),
        )
      ],
    );
  }
}
