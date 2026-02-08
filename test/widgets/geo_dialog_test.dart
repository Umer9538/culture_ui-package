import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

void main() {
  group('GeoDialog', () {
    testWidgets('shows dialog with title and content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CultureScope(
            profile: CultureProfiles.american,
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      GeoDialog.show(
                        context: context,
                        title: 'Confirm',
                        contentText: 'Are you sure?',
                        confirmLabel: 'Yes',
                        cancelLabel: 'No',
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm'), findsOneWidget);
      expect(find.text('Are you sure?'), findsOneWidget);
      expect(find.text('Yes'), findsOneWidget);
      expect(find.text('No'), findsOneWidget);
    });

    testWidgets('confirm is right of cancel for American', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CultureScope(
            profile: CultureProfiles.american,
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      GeoDialog.show(
                        context: context,
                        title: 'Test',
                        confirmLabel: 'OK',
                        cancelLabel: 'Cancel',
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final okPos = tester.getCenter(find.text('OK'));
      final cancelPos = tester.getCenter(find.text('Cancel'));
      // American: confirm-right → OK should be to the right of Cancel
      expect(okPos.dx, greaterThan(cancelPos.dx));
    });

    testWidgets('confirm is left of cancel for French', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CultureScope(
            profile: CultureProfiles.french,
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      GeoDialog.show(
                        context: context,
                        title: 'Test',
                        confirmLabel: 'Oui',
                        cancelLabel: 'Non',
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final ouiPos = tester.getCenter(find.text('Oui'));
      final nonPos = tester.getCenter(find.text('Non'));
      // French: confirm-left → Oui should be to the left of Non
      expect(ouiPos.dx, lessThan(nonPos.dx));
    });

    testWidgets('confirm button calls onConfirm and returns true', (
      tester,
    ) async {
      var confirmed = false;
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: CultureScope(
            profile: CultureProfiles.american,
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      result = await GeoDialog.show(
                        context: context,
                        title: 'Test',
                        confirmLabel: 'Yes',
                        cancelLabel: 'No',
                        onConfirm: () => confirmed = true,
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      expect(confirmed, true);
      expect(result, true);
    });

    testWidgets('cancel button calls onCancel and returns false', (
      tester,
    ) async {
      var cancelled = false;
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: CultureScope(
            profile: CultureProfiles.american,
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      result = await GeoDialog.show(
                        context: context,
                        title: 'Test',
                        confirmLabel: 'Yes',
                        cancelLabel: 'No',
                        onCancel: () => cancelled = true,
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('No'));
      await tester.pumpAndSettle();

      expect(cancelled, true);
      expect(result, false);
    });

    testWidgets('only confirm button shown when no cancelLabel', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CultureScope(
            profile: CultureProfiles.american,
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      GeoDialog.show(
                        context: context,
                        title: 'Info',
                        contentText: 'Done!',
                        confirmLabel: 'OK',
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('OK'), findsOneWidget);
      // No cancel button
      expect(find.widgetWithText(TextButton, 'Cancel'), findsNothing);
    });
  });
}
