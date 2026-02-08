import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

void main() {
  group('GeoButtonPair', () {
    testWidgets('primary button is on the right for American', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoButtonPair(
            primary: GeoButtonConfig(label: 'Save', onPressed: () {}),
            secondary: GeoButtonConfig(label: 'Cancel', onPressed: () {}),
          ),
          profile: CultureProfiles.american,
        ),
      );

      final saveButton = find.text('Save');
      final cancelButton = find.text('Cancel');
      expect(saveButton, findsOneWidget);
      expect(cancelButton, findsOneWidget);

      // Save (primary) should be to the right of Cancel (secondary)
      final savePos = tester.getCenter(saveButton);
      final cancelPos = tester.getCenter(cancelButton);
      expect(savePos.dx, greaterThan(cancelPos.dx));
    });

    testWidgets('primary button is on the left for Arabic', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoButtonPair(
            primary: GeoButtonConfig(label: 'Save', onPressed: () {}),
            secondary: GeoButtonConfig(label: 'Cancel', onPressed: () {}),
          ),
          profile: CultureProfiles.arabic,
        ),
      );

      final saveButton = find.text('Save');
      final cancelButton = find.text('Cancel');

      // Save (primary) should be to the left of Cancel (secondary)
      final savePos = tester.getCenter(saveButton);
      final cancelPos = tester.getCenter(cancelButton);
      expect(savePos.dx, lessThan(cancelPos.dx));
    });

    testWidgets('primary button onPressed fires', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        wrapWithCulture(
          GeoButtonPair(
            primary: GeoButtonConfig(
              label: 'Save',
              onPressed: () => pressed = true,
            ),
            secondary: GeoButtonConfig(label: 'Cancel', onPressed: () {}),
          ),
          profile: CultureProfiles.american,
        ),
      );

      await tester.tap(find.text('Save'));
      expect(pressed, true);
    });
  });

  group('GeoButton', () {
    testWidgets('renders as ElevatedButton when isPrimary', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoButton(label: 'Submit', onPressed: () {}),
          profile: CultureProfiles.american,
        ),
      );
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('renders as TextButton when not primary', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoButton(label: 'Skip', isPrimary: false, onPressed: () {}),
          profile: CultureProfiles.american,
        ),
      );
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
    });

    testWidgets('renders with icon', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoButton(label: 'Save', icon: Icons.save, onPressed: () {}),
          profile: CultureProfiles.american,
        ),
      );
      expect(find.byIcon(Icons.save), findsOneWidget);
    });
  });
}
