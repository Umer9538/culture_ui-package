import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  group('GeoNumber', () {
    testWidgets('formats number in American style', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoNumber(value: 1234567.89),
          profile: CultureProfiles.american,
        ),
      );
      expect(find.text('1,234,567.89'), findsOneWidget);
    });

    testWidgets('formats number in German style', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoNumber(value: 1234567.89),
          profile: CultureProfiles.german,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      // German uses . for grouping and , for decimal
      expect(text.data, contains('1.234.567'));
    });

    testWidgets('respects decimalDigits', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoNumber(value: 1234.5, decimalDigits: 3),
          profile: CultureProfiles.american,
        ),
      );
      expect(find.text('1,234.500'), findsOneWidget);
    });

    testWidgets('compact mode works', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoNumber(value: 1500000, compact: true),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      // Should be something like "1.5M"
      expect(text.data, isNotNull);
      expect(text.data!.length, lessThan(10));
    });

    testWidgets('applies text style', (tester) async {
      const style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoNumber(value: 42, textStyle: style),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 20);
      expect(text.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('formats integer without decimals', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoNumber(value: 1000),
          profile: CultureProfiles.american,
        ),
      );
      expect(find.text('1,000'), findsOneWidget);
    });
  });
}
