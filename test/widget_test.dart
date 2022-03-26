// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skysoft_assignment/view/ping_screen.dart';

void main() {
  setUp(() {});
  testWidgets('check initial state of the screen', (WidgetTester tester) async {
    final pingButton = find.byKey(ValueKey('ping button'));
    final appBar = find.byKey(ValueKey('appBar'));
    final scaffold = find.byKey(ValueKey('scaffold'));
    final appBarText = find.byKey(ValueKey('appbar text'));
    final text = find.widgetWithText(AppBar, 'Response Timer');

    await tester.pumpWidget(MaterialApp(
      home: PingProvider(),
    ));
    expect(pingButton, findsOneWidget);
    expect(appBar, findsOneWidget);
    expect(scaffold, findsOneWidget);
    expect(appBarText, findsOneWidget);
    expect(text, findsOneWidget);
  });
  testWidgets('check widgets on screen after button is tapped for first time',
      (WidgetTester tester) async {
    final pingButton = find.byKey(ValueKey('ping button'));
    final ipText = find.byKey(ValueKey('ip'));
    final outerListView = find.byKey(ValueKey('outerListView'));
    final innerListView = find.byKey(ValueKey('innerListView'));
    final totalResponseTime = find.byKey(ValueKey('totalResponseTimeText'));
    await tester.pumpWidget(MaterialApp(
      home: PingProvider(),
    ));
    await tester.tap(pingButton);
    await tester.pump(Duration(seconds: 6));
    expect(ipText, findsOneWidget);
    expect(outerListView, findsOneWidget);
    expect(innerListView, findsOneWidget);
    expect(totalResponseTime, findsOneWidget);
  });
}
