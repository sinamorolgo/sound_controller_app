import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sound_controller_app/main.dart';

void main() {
  testWidgets('App builds and shows initial timer',
      (WidgetTester tester) async {
    await tester.pumpWidget(SoundControllerApp());

    expect(find.text('Sound Controller'), findsOneWidget);
    expect(find.text('Timer: 0 min'), findsOneWidget);
    expect(find.text('+'), findsOneWidget);
    expect(find.text('–'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
  });
}
