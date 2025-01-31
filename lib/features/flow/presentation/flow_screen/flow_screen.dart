import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlowScreen extends ConsumerStatefulWidget {
  const FlowScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FlowScreenState();
}

class _FlowScreenState extends ConsumerState<FlowScreen>
    with SingleTickerProviderStateMixin {
  late final Ticker ticker;
  Duration elapsedTime = Duration.zero;
  Duration timeLimit = const Duration(seconds: 10);
  final stopwatch = Stopwatch();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ticker = createTicker((elapsed) {
      if (elapsed >= timeLimit) {
        ticker.stop();
        elapsedTime = timeLimit;
      }
      setState(() {
        elapsedTime = timeLimit - elapsed;
      });
    });
    // ticker.start();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text((elapsedTime.inMilliseconds / 1000)
            .toStringAsFixed(2)
            .replaceAll(".", ":")
            .padLeft(5, "0")),
        ElevatedButton(
            onPressed: () {
              ticker.isActive ? ticker.stop() : ticker.start();
            },
            child: Text(ticker.isActive ? "stop" : "start"))
      ],
    );
  }
}
