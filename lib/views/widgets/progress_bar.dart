// lib/views/widgets/progress_bar.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/timer_provider.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    // 남은 시간 비율 계산
    double progress = timerProvider.timerSecondsFirstSet > 0
        ? timerProvider.remainingSeconds / timerProvider.timerSecondsFirstSet
        : 0.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 20,
          backgroundColor: Colors.grey[300],
        ),
      ),
    );
  }
}
