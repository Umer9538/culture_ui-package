import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

void main() {
  group('GeoFormField', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    Widget buildField(Widget field, {CultureProfile? profile}) {
      return MaterialApp(
        home: CultureScope(
          profile: profile ?? CultureProfiles.american,
          child: Scaffold(
            body: Form(autovalidateMode: AutovalidateMode.always, child: field),
          ),
        ),
      );
    }

    testWidgets('name field shows "Full Name" for American', (tester) async {
      await tester.pumpWidget(
        buildField(GeoFormField.name(controller: controller)),
      );
      expect(find.text('Full Name'), findsOneWidget);
    });

    testWidgets('name field shows "Family Name" for Japanese', (tester) async {
      await tester.pumpWidget(
        buildField(
          GeoFormField.name(controller: controller),
          profile: CultureProfiles.japanese,
        ),
      );
      expect(find.text('Family Name'), findsOneWidget);
    });

    testWidgets('postal code validates American format', (tester) async {
      controller.text = '12345';
      await tester.pumpWidget(
        buildField(GeoFormField.postalCode(controller: controller)),
      );
      await tester.pump();
      // Valid - should not show error
      expect(find.text('Invalid postal code format'), findsNothing);
    });

    testWidgets('postal code rejects invalid American format', (tester) async {
      await tester.pumpWidget(
        buildField(GeoFormField.postalCode(controller: controller)),
      );

      await tester.enterText(find.byType(TextFormField), 'ABC');
      await tester.pump();
      expect(find.text('Invalid postal code format'), findsOneWidget);
    });

    testWidgets('postal code validates Japanese format', (tester) async {
      controller.text = '123-4567';
      await tester.pumpWidget(
        buildField(
          GeoFormField.postalCode(controller: controller),
          profile: CultureProfiles.japanese,
        ),
      );
      await tester.pump();
      expect(find.text('Invalid postal code format'), findsNothing);
    });

    testWidgets('postal code rejects invalid Japanese format', (tester) async {
      await tester.pumpWidget(
        buildField(
          GeoFormField.postalCode(controller: controller),
          profile: CultureProfiles.japanese,
        ),
      );

      await tester.enterText(find.byType(TextFormField), '12345');
      await tester.pump();
      expect(find.text('Invalid postal code format'), findsOneWidget);
    });

    testWidgets('phone field renders', (tester) async {
      await tester.pumpWidget(
        buildField(GeoFormField.phone(controller: controller)),
      );
      expect(find.text('Phone Number'), findsOneWidget);
    });

    testWidgets('custom label overrides default', (tester) async {
      await tester.pumpWidget(
        buildField(
          GeoFormField.postalCode(controller: controller, label: 'ZIP Code'),
        ),
      );
      expect(find.text('ZIP Code'), findsOneWidget);
      expect(find.text('Postal Code'), findsNothing);
    });

    testWidgets('Arabic profile shows Family Name label correctly', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildField(
          GeoFormField.name(controller: controller),
          profile: CultureProfiles.arabic,
        ),
      );
      // Arabic uses givenFirst, so should show "Full Name"
      expect(find.text('Full Name'), findsOneWidget);
    });
  });
}
