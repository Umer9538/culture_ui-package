import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

void main() {
  group('GeoColor', () {
    testWidgets('returns correct danger color for American', (tester) async {
      late Color color;

      await tester.pumpWidget(
        wrapWithCulture(
          Builder(
            builder: (context) {
              color = GeoColor.of(context, ColorSemantic.danger);
              return const SizedBox();
            },
          ),
          profile: CultureProfiles.american,
        ),
      );

      expect(color, const Color(0xFFD32F2F));
    });

    testWidgets('returns fallback when semantic not defined', (tester) async {
      late Color color;

      await tester.pumpWidget(
        wrapWithCulture(
          Builder(
            builder: (context) {
              // American profile doesn't define 'luck'
              color = GeoColor.of(
                context,
                ColorSemantic.luck,
                fallback: Colors.orange,
              );
              return const SizedBox();
            },
          ),
          profile: CultureProfiles.american,
        ),
      );

      expect(color, Colors.orange);
    });

    testWidgets('returns grey when no fallback and semantic not defined', (
      tester,
    ) async {
      late Color color;

      await tester.pumpWidget(
        wrapWithCulture(
          Builder(
            builder: (context) {
              color = GeoColor.of(context, ColorSemantic.wealth);
              return const SizedBox();
            },
          ),
          profile: CultureProfiles.american,
        ),
      );

      expect(color, Colors.grey);
    });

    testWidgets('luck is red for Chinese culture', (tester) async {
      late Color color;

      await tester.pumpWidget(
        wrapWithCulture(
          Builder(
            builder: (context) {
              color = GeoColor.of(context, ColorSemantic.luck);
              return const SizedBox();
            },
          ),
          profile: CultureProfiles.chinese,
        ),
      );

      expect(color, const Color(0xFFD32F2F));
    });

    testWidgets('maybeOf returns null without CultureScope', (tester) async {
      Color? color;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              color = GeoColor.maybeOf(context, ColorSemantic.danger);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(color, isNull);
    });

    testWidgets('allOf returns all semantics for profile', (tester) async {
      late Map<ColorSemantic, Color> colors;

      await tester.pumpWidget(
        wrapWithCulture(
          Builder(
            builder: (context) {
              colors = GeoColor.allOf(context);
              return const SizedBox();
            },
          ),
          profile: CultureProfiles.american,
        ),
      );

      expect(colors, isNotEmpty);
      expect(colors.containsKey(ColorSemantic.danger), true);
      expect(colors.containsKey(ColorSemantic.success), true);
    });
  });
}
