import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../../lib/pages/results.dart'; 

void main() {
  testWidgets('AppBar should show "Results"', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Result()));

    expect(find.widgetWithText(AppBar, 'Results'), findsOneWidget);
  });

  testWidgets('Container should have green color', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: Result()));

  final container = tester.widget<Container>(find.byType(Container));

  expect(container.color, Colors.green);
});

testWidgets('Should show "Bingo!" text', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: Result()));

  expect(find.text('Bingo!'), findsOneWidget);
});

testWidgets('Scaffold should have AppBar', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: Result()));

  final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));

  expect(scaffold.appBar, isNotNull);
});

testWidgets('Result should have Scaffold', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: Result()));

  expect(find.byType(Scaffold), findsOneWidget);
});

testWidgets('Scaffold should have Container', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: Result()));

  expect(find.byType(Container), findsOneWidget);
});

testWidgets('Container should have Center', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: Result()));

  expect(find.descendant(of: find.byType(Container), matching: find.byType(Center)), findsOneWidget);
});
}