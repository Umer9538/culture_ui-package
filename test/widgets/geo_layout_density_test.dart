import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

void main() {
  group('GeoLayoutDensity', () {
    testWidgets('applies compact padding for Japanese', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoLayoutDensity(child: Text('Content')),
          profile: CultureProfiles.japanese,
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding).first);
      expect(padding.padding, const EdgeInsets.all(8.0));
    });

    testWidgets('applies normal padding for American', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoLayoutDensity(child: Text('Content')),
          profile: CultureProfiles.american,
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding).first);
      expect(padding.padding, const EdgeInsets.all(16.0));
    });

    testWidgets('applies comfortable padding for Arabic', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoLayoutDensity(child: Text('Content')),
          profile: CultureProfiles.arabic,
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding).first);
      expect(padding.padding, const EdgeInsets.all(24.0));
    });

    testWidgets('density override works', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoLayoutDensity(
            densityOverride: LayoutDensity.compact,
            child: Text('Content'),
          ),
          profile: CultureProfiles.american, // normally "normal" density
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding).first);
      // Should use compact (8.0) even though American profile is normal
      expect(padding.padding, const EdgeInsets.all(8.0));
    });

    testWidgets('custom padding map works', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoLayoutDensity(
            customPadding: {LayoutDensity.normal: EdgeInsets.all(32.0)},
            child: Text('Content'),
          ),
          profile: CultureProfiles.american,
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding).first);
      expect(padding.padding, const EdgeInsets.all(32.0));
    });
  });

  group('GeoSpacing', () {
    testWidgets('provides correct spacing values', (tester) async {
      late GeoSpacing spacing;

      await tester.pumpWidget(
        wrapWithCulture(
          Builder(
            builder: (context) {
              spacing = GeoSpacing.of(context);
              return const SizedBox();
            },
          ),
          profile: CultureProfiles.japanese,
        ),
      );

      expect(spacing.horizontal, 8.0);
      expect(spacing.vertical, 8.0);
      expect(spacing.padding, const EdgeInsets.all(8.0));
    });
  });
}
