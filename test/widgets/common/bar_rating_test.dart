import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocktailian/widgets/common/bar_rating.dart';

void main() {
  group('BarRating Tests', () {
    testWidgets('BarRating should render with correct rating', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarRating(rating: 4.0))),
      );

      expect(find.byType(BarRating), findsOneWidget);
      // Should show 4 filled stars and 1 empty star
      expect(find.byIcon(Icons.star), findsNWidgets(4));
      expect(find.byIcon(Icons.star_border), findsNWidgets(1));
    });

    testWidgets('BarRating.readOnly should display rating with label', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarRating.readOnly(rating: 3.5, showLabel: true),
          ),
        ),
      );

      expect(find.byType(BarRating), findsOneWidget);
      expect(find.text('3.5/5'), findsOneWidget);
    });

    testWidgets('BarRating.interactive should handle rating changes', (
      WidgetTester tester,
    ) async {
      double currentRating = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarRating.interactive(
              rating: 2.0,
              onRatingChanged: (rating) => currentRating = rating,
            ),
          ),
        ),
      );

      // Tap on the first available star (index 0)
      final starIcons = find.byIcon(Icons.star);
      expect(starIcons, findsWidgets);
      await tester.tap(starIcons.first);
      await tester.pump();

      expect(currentRating, equals(1.0));
    });

    testWidgets('BarRating should handle half ratings when enabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BarRating(rating: 3.5, allowHalfRating: true)),
        ),
      );

      expect(find.byType(BarRating), findsOneWidget);
      // Should show 3 full stars, 1 half star, and 1 empty star
      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_half), findsNWidgets(1));
      expect(find.byIcon(Icons.star_border), findsNWidgets(1));
    });

    testWidgets('BarRating should show custom label when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarRating(
              rating: 4.0,
              showLabel: true,
              label: 'Custom Label',
            ),
          ),
        ),
      );

      expect(find.text('Custom Label'), findsOneWidget);
    });

    testWidgets('BarRatingCompact should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BarRatingCompact(rating: 4.2, reviewCount: 150)),
        ),
      );

      expect(find.byType(BarRatingCompact), findsOneWidget);
      expect(find.text('4.2'), findsOneWidget);
      expect(find.text('(150)'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('BarRatingSummary should render breakdown correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarRatingSummary(
              averageRating: 4.3,
              totalReviews: 100,
              ratingBreakdown: {5: 50, 4: 30, 3: 15, 2: 3, 1: 2},
            ),
          ),
        ),
      );

      expect(find.byType(BarRatingSummary), findsOneWidget);
      expect(find.text('4.3'), findsOneWidget);
      expect(find.text('100 reviews'), findsOneWidget);

      // Should show progress bars for each rating level
      expect(find.byType(LinearProgressIndicator), findsNWidgets(5));

      // Should show counts for each rating
      expect(find.text('50'), findsOneWidget);
      expect(find.text('30'), findsOneWidget);
      expect(find.text('15'), findsOneWidget);

      // "3" and "2" appear twice (count and rating level), so check for at least one
      expect(find.text('3'), findsAtLeastNWidgets(1));
      expect(find.text('2'), findsAtLeastNWidgets(1));
    });

    testWidgets('BarRatingSummary should handle view all reviews callback', (
      WidgetTester tester,
    ) async {
      bool viewAllPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarRatingSummary(
              averageRating: 4.0,
              totalReviews: 50,
              ratingBreakdown: {5: 25, 4: 15, 3: 7, 2: 2, 1: 1},
              onViewAllReviews: () => viewAllPressed = true,
            ),
          ),
        ),
      );

      expect(find.text('View All Reviews'), findsOneWidget);

      await tester.tap(find.text('View All Reviews'));
      await tester.pump();

      expect(viewAllPressed, isTrue);
    });

    testWidgets('BarRating should use custom colors when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarRating(
              rating: 3.0,
              activeColor: Colors.red,
              inactiveColor: Colors.grey,
            ),
          ),
        ),
      );

      expect(find.byType(BarRating), findsOneWidget);

      final rating = tester.widget<BarRating>(find.byType(BarRating));
      expect(rating.activeColor, equals(Colors.red));
      expect(rating.inactiveColor, equals(Colors.grey));
    });
  });
}
