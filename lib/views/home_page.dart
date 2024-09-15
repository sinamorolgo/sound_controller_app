import 'package:flutter/material.dart';
import 'widgets/timer_display.dart';
import 'widgets/control_buttons.dart';
import 'widgets/progress_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sound Controller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProgressBar(),
            TimerDisplay(),
            SizedBox(height: 20),
            ControlButtons(),
          ],
        ),
      ),
    );
  }
}
