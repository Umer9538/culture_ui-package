import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

void main() {
  group('GeoText', () {
    testWidgets('renders text', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('Hello World'),
          profile: CultureProfiles.american,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('sets LTR direction for American', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('Hello'),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.textDirection, TextDirection.ltr);
    });

    testWidgets('sets RTL direction for Arabic', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('مرحبا'),
          profile: CultureProfiles.arabic,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.textDirection, TextDirection.rtl);
    });

    testWidgets('emphasize applies bold for American', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('Important', emphasize: true),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('emphasize applies dotted underline for Japanese', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('重要', emphasize: true),
          profile: CultureProfiles.japanese,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.decoration, TextDecoration.underline);
      expect(text.style?.decorationStyle, TextDecorationStyle.dotted);
    });

    testWidgets('no emphasis when emphasize is false', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('Normal'),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      // Should not have bold applied
      expect(text.style?.fontWeight, isNot(FontWeight.bold));
    });

    testWidgets('respects maxLines', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('Long text', maxLines: 1),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.maxLines, 1);
      expect(text.overflow, TextOverflow.ellipsis);
    });

    testWidgets('no overflow when maxLines is null', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('Text'),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.overflow, isNull);
    });

    testWidgets('applies custom text style', (tester) async {
      const style = TextStyle(fontSize: 30, color: Colors.blue);
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('Styled', textStyle: style),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 30);
      expect(text.style?.color, Colors.blue);
    });

    testWidgets('respects textAlign', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('Centered', textAlign: TextAlign.center),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.textAlign, TextAlign.center);
    });

    testWidgets('emphasize with underline style', (tester) async {
      final profile = CultureProfiles.american.copyWith(
        textEmphasisStyle: TextEmphasisStyle.underline,
      );
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText('Underlined', emphasize: true),
          profile: profile,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.decoration, TextDecoration.underline);
    });

    testWidgets('emphasize with enlarged size', (tester) async {
      final profile = CultureProfiles.american.copyWith(
        textEmphasisStyle: TextEmphasisStyle.enlargedSize,
      );
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoText(
            'Big',
            emphasize: true,
            textStyle: TextStyle(fontSize: 14),
          ),
          profile: profile,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      // 14 * 1.2 = 16.8
      expect(text.style?.fontSize, closeTo(16.8, 0.1));
    });
  });
}
