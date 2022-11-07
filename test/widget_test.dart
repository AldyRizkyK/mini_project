// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project/screens/plant/empty_page.dart';
import 'package:mini_project/screens/plant/home_page.dart';
import 'package:mini_project/screens/splash/splash_screen.dart';

void main() {
  testWidgets(
    'Check Text',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: EmptyPlantScreen(),
        ),
      );
      expect(find.text('You Dont Have Any Plant'), findsOneWidget);
    },
  );
}
