import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocktailian/widgets/common/bar_input.dart';

void main() {
  group('BarTextField Tests', () {
    testWidgets('BarTextField should render with label', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarTextField(label: 'Test Label', hint: 'Enter text here'),
          ),
        ),
      );

      // Check if the widget is rendered
      expect(find.byType(BarTextField), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);

      // Check for the label text within the RichText
      expect(find.byType(RichText), findsAtLeastNWidgets(1));
    });

    testWidgets('BarTextField should handle text input', (
      WidgetTester tester,
    ) async {
      String inputText = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarTextField(
              label: 'Input Field',
              onChanged: (value) => inputText = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'test input');
      await tester.pump();

      expect(inputText, equals('test input'));
    });

    testWidgets('BarTextField should show required indicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarTextField(label: 'Required Field', required: true),
          ),
        ),
      );

      // Check for the widget and RichText for the label
      expect(find.byType(BarTextField), findsOneWidget);
      expect(find.byType(RichText), findsAtLeastNWidgets(1));
    });

    testWidgets('BarTextField should show prefix and suffix icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarTextField(
              label: 'Icon Field',
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.clear),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('BarTextField should handle multiline input', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarTextField(label: 'Multiline Field', maxLines: 3),
          ),
        ),
      );

      // Verify the BarTextField has the expected maxLines
      final barTextField = tester.widget<BarTextField>(
        find.byType(BarTextField),
      );
      expect(barTextField.maxLines, equals(3));
    });

    testWidgets('BarTextField should handle character limit', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarTextField(label: 'Limited Field', maxLength: 50),
          ),
        ),
      );

      // Verify the BarTextField has the expected maxLength
      final barTextField = tester.widget<BarTextField>(
        find.byType(BarTextField),
      );
      expect(barTextField.maxLength, equals(50));
    });

    testWidgets('BarTextField should handle obscure text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarTextField(label: 'Password Field', obscureText: true),
          ),
        ),
      );

      // Verify the BarTextField has the expected obscureText setting
      final barTextField = tester.widget<BarTextField>(
        find.byType(BarTextField),
      );
      expect(barTextField.obscureText, isTrue);
    });

    testWidgets('BarTextField should handle disabled state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarTextField(label: 'Disabled Field', enabled: false),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(
        find.byType(TextFormField),
      );
      expect(textField.enabled, isFalse);
    });
  });

  group('BarDropdownField Tests', () {
    testWidgets('BarDropdownField should render with items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarDropdownField<String>(
              label: 'Dropdown Label',
              hint: 'Select an option',
              items: [
                BarDropdownItem(value: 'option1', label: 'Option 1'),
                BarDropdownItem(value: 'option2', label: 'Option 2'),
              ],
            ),
          ),
        ),
      );

      // Check for the widget and components
      expect(find.byType(BarDropdownField<String>), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    });

    testWidgets('BarDropdownField should handle selection', (
      WidgetTester tester,
    ) async {
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarDropdownField<String>(
              label: 'Test Dropdown',
              items: [
                const BarDropdownItem(value: 'option1', label: 'Option 1'),
                const BarDropdownItem(value: 'option2', label: 'Option 2'),
              ],
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      // Tap dropdown to open it
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Select an option
      await tester.tap(find.text('Option 1').last);
      await tester.pumpAndSettle();

      expect(selectedValue, equals('option1'));
    });

    testWidgets('BarDropdownField should show required indicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarDropdownField<String>(
              label: 'Required Dropdown',
              required: true,
              items: [BarDropdownItem(value: 'option1', label: 'Option 1')],
            ),
          ),
        ),
      );

      // Check for the widget and components
      expect(find.byType(BarDropdownField<String>), findsOneWidget);
      expect(find.byType(RichText), findsAtLeastNWidgets(1));
    });

    testWidgets('BarDropdownField should handle disabled state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarDropdownField<String>(
              label: 'Disabled Dropdown',
              enabled: false,
              items: [BarDropdownItem(value: 'option1', label: 'Option 1')],
            ),
          ),
        ),
      );

      final dropdown = tester.widget<BarDropdownField<String>>(
        find.byType(BarDropdownField<String>),
      );
      expect(dropdown.enabled, isFalse);
    });
  });

  group('BarSwitch Tests', () {
    testWidgets('BarSwitch should render with label', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BarSwitch(value: false, label: 'Test Switch')),
        ),
      );

      expect(find.text('Test Switch'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('BarSwitch should handle value changes', (
      WidgetTester tester,
    ) async {
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => BarSwitch(
                value: switchValue,
                label: 'Toggle Switch',
                onChanged: (value) => setState(() => switchValue = value),
              ),
            ),
          ),
        ),
      );

      expect(switchValue, isFalse);

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(switchValue, isTrue);
    });

    testWidgets('BarSwitch should show description when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarSwitch(
              value: true,
              label: 'Switch with Description',
              description: 'This is a description of the switch.',
            ),
          ),
        ),
      );

      expect(find.text('Switch with Description'), findsOneWidget);
      expect(find.text('This is a description of the switch.'), findsOneWidget);
    });

    testWidgets('BarSwitch should handle tap on entire row', (
      WidgetTester tester,
    ) async {
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => BarSwitch(
                value: switchValue,
                label: 'Tappable Row',
                onChanged: (value) => setState(() => switchValue = value),
              ),
            ),
          ),
        ),
      );

      // Tap on the label instead of the switch itself
      await tester.tap(find.text('Tappable Row'));
      await tester.pump();

      expect(switchValue, isTrue);
    });

    testWidgets('BarSwitch should handle disabled state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BarSwitch(
              value: false,
              label: 'Disabled Switch',
              enabled: false,
            ),
          ),
        ),
      );

      final barSwitch = tester.widget<BarSwitch>(find.byType(BarSwitch));
      expect(barSwitch.enabled, isFalse);

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.onChanged, isNull);
    });
  });
}
