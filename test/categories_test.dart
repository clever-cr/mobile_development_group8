
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharp_mind/pages/categories.dart';

void main() {
  testWidgets('AppBar shows "Categories"', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Category()));
    expect(find.widgetWithText(AppBar, 'Categories'), findsOneWidget);
  });
}
