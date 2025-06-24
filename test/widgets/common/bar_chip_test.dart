import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocktailian/widgets/common/bar_chip.dart';

void main() {
  group('BarChip Tests', () {
    testWidgets('BarChip should render with label', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BarChip(label: 'Test Chip')),
        ),
      );

      expect(find.text('Test Chip'), findsOneWidget);
      expect(find.byType(BarChip), findsOneWidget);
    });

    testWidgets('BarChip.ingredient should handle tap events', (
      WidgetTester tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarChip.ingredient(
              label: 'Vodka',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(BarChip));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('BarChip should show selected state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarChip(label: 'Selected Chip', isSelected: true),
          ),
        ),
      );

      final chip = tester.widget<BarChip>(find.byType(BarChip));
      expect(chip.isSelected, isTrue);
    });

    testWidgets('BarChip should show unavailable state for ingredients', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarChip.ingredient(label: 'Gin', isAvailable: false),
          ),
        ),
      );

      expect(find.text('Gin'), findsOneWidget);
      expect(find.byIcon(Icons.remove_circle), findsOneWidget);
    });

    testWidgets('BarChip should show icon when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarChip(label: 'Icon Chip', icon: Icons.star),
          ),
        ),
      );

      expect(find.text('Icon Chip'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('BarChip.category should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarChip.category(label: 'Sweet', icon: Icons.favorite),
          ),
        ),
      );

      expect(find.text('Sweet'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);

      final chip = tester.widget<BarChip>(find.byType(BarChip));
      expect(chip.type, equals(BarChipType.category));
    });

    testWidgets('BarChip.filter should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarChip.filter(
              label: 'Strong',
              icon: Icons.local_fire_department,
            ),
          ),
        ),
      );

      expect(find.text('Strong'), findsOneWidget);
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);

      final chip = tester.widget<BarChip>(find.byType(BarChip));
      expect(chip.type, equals(BarChipType.filter));
    });

    testWidgets('BarChip should handle delete callback', (
      WidgetTester tester,
    ) async {
      bool deleted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarChip.filter(
              label: 'Deletable',
              onDeleted: () => deleted = true,
            ),
          ),
        ),
      );

      // Should show close icon when onDeleted is provided
      expect(find.byIcon(Icons.close), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(deleted, isTrue);
    });
  });
}
