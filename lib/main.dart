import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/timer_provider.dart';
import 'views/home_page.dart';
import 'services/volume_service_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TimerProvider(getVolumeService()),
      child: SoundControllerApp(),
    ),
  );
}

class SoundControllerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
