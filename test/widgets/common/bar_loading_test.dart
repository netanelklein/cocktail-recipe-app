import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocktailian/widgets/common/bar_loading.dart';

void main() {
  group('BarLoading Tests', () {
    testWidgets('BarLoading.spinner should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarLoading.spinner())),
      );

      expect(find.byType(BarLoading), findsOneWidget);

      final loading = tester.widget<BarLoading>(find.byType(BarLoading));
      expect(loading.type, equals(BarLoadingType.spinner));
    });

    testWidgets('BarLoading.pulse should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarLoading.pulse())),
      );

      expect(find.byType(BarLoading), findsOneWidget);

      final loading = tester.widget<BarLoading>(find.byType(BarLoading));
      expect(loading.type, equals(BarLoadingType.pulse));
    });

    testWidgets('BarLoading.shimmer should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarLoading.shimmer())),
      );

      expect(find.byType(BarLoading), findsOneWidget);

      final loading = tester.widget<BarLoading>(find.byType(BarLoading));
      expect(loading.type, equals(BarLoadingType.shimmer));
    });

    testWidgets('BarLoading should show message when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BarLoading(message: 'Loading cocktails...')),
        ),
      );

      expect(find.text('Loading cocktails...'), findsOneWidget);
    });

    testWidgets('BarLoading should use custom size', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BarLoading(size: 50))),
      );

      final loading = tester.widget<BarLoading>(find.byType(BarLoading));
      expect(loading.size, equals(50));
    });

    testWidgets('BarLoading should use custom color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BarLoading(color: Colors.blue)),
        ),
      );

      final loading = tester.widget<BarLoading>(find.byType(BarLoading));
      expect(loading.color, equals(Colors.blue));
    });

    testWidgets('BarLoadingOverlay should show/hide based on isLoading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarLoadingOverlay(
              isLoading: true,
              child: Text('Child Content'),
            ),
          ),
        ),
      );

      expect(find.byType(BarLoadingOverlay), findsOneWidget);
      expect(find.text('Child Content'), findsOneWidget);
      expect(find.byType(BarLoading), findsOneWidget);
    });

    testWidgets(
      'BarLoadingOverlay should not show loading when isLoading is false',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: BarLoadingOverlay(
                isLoading: false,
                child: Text('Child Content'),
              ),
            ),
          ),
        );

        expect(find.byType(BarLoadingOverlay), findsOneWidget);
        expect(find.text('Child Content'), findsOneWidget);
        expect(find.byType(BarLoading), findsNothing);
      },
    );

    testWidgets('BarLoadingOverlay should show message when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarLoadingOverlay(
              isLoading: true,
              message: 'Please wait...',
              child: Text('Child Content'),
            ),
          ),
        ),
      );

      expect(find.text('Please wait...'), findsOneWidget);
    });

    testWidgets('BarLoadingOverlay should use custom backdrop color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarLoadingOverlay(
              isLoading: true,
              backdropColor: Colors.red.withValues(alpha: 0.5),
              child: const Text('Child Content'),
            ),
          ),
        ),
      );

      final overlay = tester.widget<BarLoadingOverlay>(
        find.byType(BarLoadingOverlay),
      );
      expect(overlay.backdropColor, equals(Colors.red.withValues(alpha: 0.5)));
    });
  });
}
