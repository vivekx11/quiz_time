import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_app/main.dart';

void main() {
  testWidgets('Quiz app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuizApp());

    // Verify that the splash screen shows up
    expect(find.text('QUIZ GAME'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
  });
}
