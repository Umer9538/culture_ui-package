import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

void main() {
  group('CultureBuildContext extension', () {
    testWidgets('context.culture returns correct profile', (tester) async {
      late CultureProfile capturedProfile;

      await tester.pumpWidget(
        wrapWithCulture(
          Builder(
            builder: (context) {
              capturedProfile = context.culture;
              return const SizedBox();
            },
          ),
          profile: CultureProfiles.french,
        ),
      );

      expect(capturedProfile, CultureProfiles.french);
    });

    testWidgets('context.maybeCulture returns null without CultureScope', (
      tester,
    ) async {
      CultureProfile? capturedProfile;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedProfile = context.maybeCulture;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedProfile, isNull);
    });

    testWidgets('context.maybeCulture returns profile with CultureScope', (
      tester,
    ) async {
      CultureProfile? capturedProfile;

      await tester.pumpWidget(
        wrapWithCulture(
          Builder(
            builder: (context) {
              capturedProfile = context.maybeCulture;
              return const SizedBox();
            },
          ),
          profile: CultureProfiles.korean,
        ),
      );

      expect(capturedProfile, CultureProfiles.korean);
    });
  });
}
