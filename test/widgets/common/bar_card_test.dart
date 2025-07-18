import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocktailian/widgets/common/bar_card.dart';

void main() {
  group('BarCard Tests', () {
    testWidgets('BarCard should render with required title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BarCard(title: 'Test Cocktail')),
        ),
      );

      expect(find.text('Test Cocktail'), findsOneWidget);
      expect(find.byType(BarCard), findsOneWidget);
    });

    testWidgets('BarCard should show subtitle when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarCard(
              title: 'Test Cocktail',
              subtitle: 'A delicious test cocktail',
            ),
          ),
        ),
      );

      expect(find.text('Test Cocktail'), findsOneWidget);
      expect(find.text('A delicious test cocktail'), findsOneWidget);
    });

    testWidgets('BarCard should handle tap events', (
      WidgetTester tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarCard(title: 'Tappable Card', onTap: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.byType(BarCard));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('BarCard should show rating when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BarCard(title: 'Rated Cocktail', rating: 4.5)),
        ),
      );

      expect(find.text('Rated Cocktail'), findsOneWidget);
      // Should find star icons for rating display
      expect(find.byIcon(Icons.star), findsWidgets);
    });

    testWidgets('BarCard should display missing ingredients count', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarCard(title: 'Missing Ingredients', missingIngredients: 2),
          ),
        ),
      );

      expect(find.text('Missing Ingredients'), findsOneWidget);
      expect(find.text('2 missing'), findsOneWidget);
    });

    testWidgets('BarCard should show tags when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarCard(
              title: 'Tagged Cocktail',
              tags: ['Sweet', 'Fruity', 'Summer'],
            ),
          ),
        ),
      );

      expect(find.text('Tagged Cocktail'), findsOneWidget);
      expect(find.text('Sweet'), findsOneWidget);
      expect(find.text('Fruity'), findsOneWidget);
      expect(find.text('Summer'), findsOneWidget);
    });

    testWidgets('BarCard should show selected state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarCard(title: 'Selected Card', isSelected: true),
          ),
        ),
      );

      expect(find.text('Selected Card'), findsOneWidget);
      // The card should have different styling when selected
      final card = tester.widget<BarCard>(find.byType(BarCard));
      expect(card.isSelected, isTrue);
    });

    testWidgets('BarCard should show trailing widget when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarCard(
              title: 'Card with Trailing',
              trailing: Icon(Icons.favorite),
            ),
          ),
        ),
      );

      expect(find.text('Card with Trailing'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}
