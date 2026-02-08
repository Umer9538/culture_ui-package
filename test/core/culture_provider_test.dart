import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

void main() {
  group('CultureScope', () {
    testWidgets('provides profile to descendants via of()', (tester) async {
      late CultureProfile capturedProfile;

      await tester.pumpWidget(
        wrapWithCulture(
          Builder(
            builder: (context) {
              capturedProfile = CultureScope.of(context);
              return const SizedBox();
            },
          ),
          profile: CultureProfiles.japanese,
        ),
      );

      expect(capturedProfile, CultureProfiles.japanese);
    });

    testWidgets('maybeOf returns null when no CultureScope exists', (
      tester,
    ) async {
      CultureProfile? capturedProfile;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedProfile = CultureScope.maybeOf(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedProfile, isNull);
    });

    testWidgets('maybeOf returns profile when CultureScope exists', (
      tester,
    ) async {
      CultureProfile? capturedProfile;

      await tester.pumpWidget(
        wrapWithCulture(
          Builder(
            builder: (context) {
              capturedProfile = CultureScope.maybeOf(context);
              return const SizedBox();
            },
          ),
          profile: CultureProfiles.german,
        ),
      );

      expect(capturedProfile, CultureProfiles.german);
    });

    testWidgets('nested CultureScope overrides parent', (tester) async {
      late CultureProfile outerProfile;
      late CultureProfile innerProfile;

      await tester.pumpWidget(
        MaterialApp(
          home: CultureScope(
            profile: CultureProfiles.american,
            child: Column(
              children: [
                Builder(
                  builder: (context) {
                    outerProfile = CultureScope.of(context);
                    return const SizedBox();
                  },
                ),
                CultureScope(
                  profile: CultureProfiles.arabic,
                  child: Builder(
                    builder: (context) {
                      innerProfile = CultureScope.of(context);
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(outerProfile, CultureProfiles.american);
      expect(innerProfile, CultureProfiles.arabic);
    });

    testWidgets('resolves from explicit locale when no profile given', (
      tester,
    ) async {
      late CultureProfile capturedProfile;

      await tester.pumpWidget(
        MaterialApp(
          home: CultureScope(
            locale: const Locale('ja', 'JP'),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  capturedProfile = CultureScope.of(context);
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      );

      expect(capturedProfile, CultureProfiles.japanese);
    });

    testWidgets('rebuilds when profile changes', (tester) async {
      CultureProfile? capturedProfile;
      CultureProfile currentProfile = CultureProfiles.american;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return CultureScope(
                profile: currentProfile,
                child: Builder(
                  builder: (context) {
                    capturedProfile = CultureScope.of(context);
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentProfile = CultureProfiles.japanese;
                        });
                      },
                      child: const Text('Switch'),
                    );
                  },
                ),
              );
            },
          ),
        ),
      );

      expect(capturedProfile, CultureProfiles.american);

      await tester.tap(find.text('Switch'));
      await tester.pump();

      expect(capturedProfile, CultureProfiles.japanese);
    });
  });
}
