import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocktailian/widgets/common/bar_modal.dart';

void main() {
  group('BarModal Tests', () {
    testWidgets('BarModal.showDialog should display dialog', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  BarModal.showDialog(
                    context,
                    title: 'Test Dialog',
                    child: const Text('Dialog content'),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Test Dialog'), findsOneWidget);
      expect(find.text('Dialog content'), findsOneWidget);
    });

    testWidgets('BarModal.showDialog should handle actions', (
      WidgetTester tester,
    ) async {
      bool actionPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  BarModal.showDialog(
                    context,
                    title: 'Test Dialog',
                    child: const Text('Dialog content'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          actionPressed = true;
                          Navigator.of(context).pop();
                        },
                        child: const Text('Action'),
                      ),
                    ],
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Action'), findsOneWidget);

      await tester.tap(find.text('Action'));
      await tester.pumpAndSettle();

      expect(actionPressed, isTrue);
    });

    testWidgets('BarModal.showBottomSheet should display bottom sheet', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  BarModal.showBottomSheet(
                    context,
                    title: 'Test Bottom Sheet',
                    child: const Text('Bottom sheet content'),
                  );
                },
                child: const Text('Show Bottom Sheet'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Bottom Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Test Bottom Sheet'), findsOneWidget);
      expect(find.text('Bottom sheet content'), findsOneWidget);
    });

    testWidgets(
      'BarModal.showConfirmation should display confirmation dialog',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    await BarModal.showConfirmation(
                      context,
                      title: 'Confirm Action',
                      message: 'Are you sure?',
                    );
                  },
                  child: const Text('Show Confirmation'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Confirmation'));
        await tester.pumpAndSettle();

        expect(find.text('Confirm Action'), findsOneWidget);
        expect(find.text('Are you sure?'), findsOneWidget);
        expect(find.text('Confirm'), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
      },
    );

    testWidgets('BarModal.showConfirmation should return true when confirmed', (
      WidgetTester tester,
    ) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await BarModal.showConfirmation(
                    context,
                    title: 'Confirm Action',
                    message: 'Are you sure?',
                  );
                },
                child: const Text('Show Confirmation'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Confirmation'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });

    testWidgets(
      'BarModal.showConfirmation should return false when cancelled',
      (WidgetTester tester) async {
        bool? result;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    result = await BarModal.showConfirmation(
                      context,
                      title: 'Confirm Action',
                      message: 'Are you sure?',
                    );
                  },
                  child: const Text('Show Confirmation'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Confirmation'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(result, isFalse);
      },
    );

    testWidgets('BarModal.showConfirmation should handle destructive style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  BarModal.showConfirmation(
                    context,
                    title: 'Delete Item',
                    message: 'This action cannot be undone.',
                    confirmText: 'Delete',
                    isDestructive: true,
                  );
                },
                child: const Text('Show Destructive'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Destructive'));
      await tester.pumpAndSettle();

      expect(find.text('Delete Item'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('BarModal dialog should close when close button is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  BarModal.showDialog(
                    context,
                    title: 'Closable Dialog',
                    child: const Text('Dialog content'),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Closable Dialog'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Closable Dialog'), findsNothing);
    });
  });

  group('BarModalContent Tests', () {
    testWidgets('BarModalContent should render title and content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarModalContent(
              title: 'Modal Title',
              child: Text('Modal content'),
            ),
          ),
        ),
      );

      expect(find.text('Modal Title'), findsOneWidget);
      expect(find.text('Modal content'), findsOneWidget);
    });

    testWidgets('BarModalContent should show subtitle when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarModalContent(
              title: 'Modal Title',
              subtitle: 'Modal subtitle',
              child: Text('Modal content'),
            ),
          ),
        ),
      );

      expect(find.text('Modal Title'), findsOneWidget);
      expect(find.text('Modal subtitle'), findsOneWidget);
      expect(find.text('Modal content'), findsOneWidget);
    });

    testWidgets('BarModalContent should show actions when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarModalContent(
              title: 'Modal Title',
              actions: [
                TextButton(onPressed: () {}, child: const Text('Action 1')),
                TextButton(onPressed: () {}, child: const Text('Action 2')),
              ],
              child: const Text('Modal content'),
            ),
          ),
        ),
      );

      expect(find.text('Action 1'), findsOneWidget);
      expect(find.text('Action 2'), findsOneWidget);
    });
  });
}
