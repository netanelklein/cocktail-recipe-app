// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cocktailian/main.dart';
import 'package:cocktailian/widget_showcase_screen.dart';

void main() {
  testWidgets('Cocktailian app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: CocktailianApp()));

    // Verify that our app loads with the widget showcase
    expect(find.text('Widget Showcase'), findsOneWidget);
    expect(find.text('Buttons'), findsOneWidget);

    // Verify that the widget showcase screen is present.
    expect(find.byType(WidgetShowcaseScreen), findsOneWidget);
  });
}
