import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocktailian/widgets/common/bar_empty_state.dart';

void main() {
  group('BarEmptyState Tests', () {
    testWidgets('BarEmptyState should render with title and message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarEmptyState(
              icon: Icons.local_bar,
              title: 'No Cocktails',
              message: 'No cocktails found matching your criteria.',
            ),
          ),
        ),
      );

      expect(find.text('No Cocktails'), findsOneWidget);
      expect(
        find.text('No cocktails found matching your criteria.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.local_bar), findsOneWidget);
    });

    testWidgets('BarEmptyState.noCocktails should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarEmptyState.noCocktails())),
      );

      expect(find.text('No Cocktails Found'), findsOneWidget);
      expect(
        find.text(
          'Try adjusting your filters or search terms to find more cocktails.',
        ),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.local_bar), findsOneWidget);
    });

    testWidgets('BarEmptyState.noIngredients should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarEmptyState.noIngredients())),
      );

      expect(find.text('No Ingredients Yet'), findsOneWidget);
      expect(
        find.text(
          'Add ingredients to your inventory to discover cocktails you can make.',
        ),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.inventory_2), findsOneWidget);
    });

    testWidgets('BarEmptyState.noFavorites should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarEmptyState.noFavorites())),
      );

      expect(find.text('No Favorites'), findsOneWidget);
      expect(
        find.text('Mark cocktails as favorites to see them here.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('BarEmptyState.noResults should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarEmptyState.noResults())),
      );

      expect(find.text('No Results'), findsOneWidget);
      expect(
        find.text(
          'Your search didn\'t match any cocktails. Try different keywords.',
        ),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.search_off), findsOneWidget);
    });

    testWidgets('BarEmptyState.offline should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarEmptyState.offline())),
      );

      expect(find.text('You\'re Offline'), findsOneWidget);
      expect(
        find.text('Check your internet connection and try again.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
    });

    testWidgets('BarEmptyState should show action button when provided', (
      WidgetTester tester,
    ) async {
      bool actionPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarEmptyState(
              icon: Icons.add,
              title: 'Empty State',
              message: 'Nothing here yet.',
              actionText: 'Add Item',
              onAction: () => actionPressed = true,
            ),
          ),
        ),
      );

      expect(find.text('Add Item'), findsOneWidget);

      await tester.tap(find.text('Add Item'));
      await tester.pump();

      expect(actionPressed, isTrue);
    });

    testWidgets('BarEmptyState should use custom icon when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarEmptyState(
              icon: Icons.star,
              title: 'Custom Icon',
              message: 'This uses a custom icon.',
              customIcon: Icon(Icons.favorite, size: 80),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNothing);
    });

    testWidgets('BarEmptyState should use custom icon color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarEmptyState(
              icon: Icons.star,
              title: 'Custom Color',
              message: 'This uses a custom color.',
              iconColor: Colors.red,
            ),
          ),
        ),
      );

      final emptyState = tester.widget<BarEmptyState>(
        find.byType(BarEmptyState),
      );
      expect(emptyState.iconColor, equals(Colors.red));
    });
  });

  group('BarEmptyStateCompact Tests', () {
    testWidgets('BarEmptyStateCompact should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarEmptyStateCompact(
              icon: Icons.inbox,
              message: 'No items to display',
            ),
          ),
        ),
      );

      expect(find.text('No items to display'), findsOneWidget);
      expect(find.byIcon(Icons.inbox), findsOneWidget);
    });

    testWidgets('BarEmptyStateCompact.noItems should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarEmptyStateCompact.noItems())),
      );

      expect(find.text('No items to display'), findsOneWidget);
      expect(find.byIcon(Icons.inbox), findsOneWidget);
    });

    testWidgets('BarEmptyStateCompact.noResults should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BarEmptyStateCompact.noResults()),
        ),
      );

      expect(find.text('No results found'), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);
    });

    testWidgets('BarEmptyStateCompact should use custom icon size', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarEmptyStateCompact(
              icon: Icons.star,
              message: 'Custom size',
              iconSize: 50,
            ),
          ),
        ),
      );

      final compact = tester.widget<BarEmptyStateCompact>(
        find.byType(BarEmptyStateCompact),
      );
      expect(compact.iconSize, equals(50));
    });
  });

  group('BarEmptyStateAnimated Tests', () {
    testWidgets('BarEmptyStateAnimated should render with animation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarEmptyStateAnimated(
              icon: Icons.star,
              title: 'Animated Empty State',
              message: 'This appears with animation.',
            ),
          ),
        ),
      );

      expect(find.byType(BarEmptyStateAnimated), findsOneWidget);
      expect(find.text('Animated Empty State'), findsOneWidget);
      expect(find.text('This appears with animation.'), findsOneWidget);
    });

    testWidgets('BarEmptyStateAnimated should handle action button', (
      WidgetTester tester,
    ) async {
      bool actionPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarEmptyStateAnimated(
              icon: Icons.add,
              title: 'Animated with Action',
              message: 'Press the button below.',
              actionText: 'Take Action',
              onAction: () => actionPressed = true,
            ),
          ),
        ),
      );

      // Wait for animation to complete
      await tester.pumpAndSettle();

      expect(find.text('Take Action'), findsOneWidget);

      await tester.tap(find.text('Take Action'));
      await tester.pump();

      expect(actionPressed, isTrue);
    });
  });
}
