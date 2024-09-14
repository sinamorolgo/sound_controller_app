// lib/views/widgets/control_buttons.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/timer_provider.dart';

class ControlButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: timerProvider.decrementTimer,
              child: const Text('-'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: timerProvider.incrementTimer,
              child: const Text('+'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (timerProvider.isRunning) {
              timerProvider.stopTimer();
            } else {
              timerProvider.startTimer();
            }
          },
          child: Text(timerProvider.isRunning ? 'Stop' : 'Start'),
        ),
      ],
    );
  }
}
