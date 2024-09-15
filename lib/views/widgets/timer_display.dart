import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/timer_provider.dart';

class TimerDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    int minutes = timerProvider.timerMinutes;
    int seconds = timerProvider.timerSeconds;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return Text(
      '$minutesStr:$secondsStr',
      style: TextStyle(fontSize: 24),
    );
  }
}
