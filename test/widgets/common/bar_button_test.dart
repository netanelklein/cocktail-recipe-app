import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocktailian/widgets/common/bar_button.dart';

void main() {
  group('BarButton Tests', () {
    testWidgets('BarButton.primary should render correctly', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarButton.primary(
              text: 'Test Button',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      // Verify button is displayed
      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(BarButton), findsOneWidget);

      // Test button press
      await tester.tap(find.byType(BarButton));
      await tester.pump();
      expect(pressed, isTrue);
    });

    testWidgets('BarButton.secondary should render with correct style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarButton.secondary(
              text: 'Secondary Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Secondary Button'), findsOneWidget);
      expect(find.byType(BarButton), findsOneWidget);
    });

    testWidgets('BarButton.tertiary should render with correct style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarButton.tertiary(text: 'Tertiary Button', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Tertiary Button'), findsOneWidget);
      expect(find.byType(BarButton), findsOneWidget);
    });

    testWidgets('BarButton should show loading state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarButton.primary(
              text: 'Loading Button',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Should show circular progress indicator when loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading Button'), findsNothing);
    });

    testWidgets('BarButton should be disabled when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarButton.primary(text: 'Disabled Button', onPressed: null),
          ),
        ),
      );

      expect(find.text('Disabled Button'), findsOneWidget);

      // Try tapping disabled button
      await tester.tap(find.byType(BarButton));
      await tester.pump();
      // Should not crash or cause issues
    });

    testWidgets('BarButton should handle custom width', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarButton.primary(
              text: 'Custom Width',
              width: 200,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Custom Width'), findsOneWidget);

      // Verify the widget has the expected width
      final buttonWidget = tester.widget<Container>(
        find
            .ancestor(
              of: find.byType(ElevatedButton),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(buttonWidget.constraints?.maxWidth, equals(200));
    });

    testWidgets('BarButton should show icon when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarButton.primary(
              text: 'Icon Button',
              icon: Icons.add,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Icon Button'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
