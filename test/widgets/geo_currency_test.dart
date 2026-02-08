import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  group('GeoCurrency', () {
    testWidgets('formats USD in American style', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoCurrency(amount: 1234.50),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.data, contains(r'$'));
      expect(text.data, contains('1,234.50'));
    });

    testWidgets('formats JPY with 0 decimal digits', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoCurrency(amount: 1234.50),
          profile: CultureProfiles.japanese,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.data, contains('¥'));
      // JPY has 0 decimal digits, so should round
      expect(text.data, contains('1,235'));
    });

    testWidgets('symbol override works', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoCurrency(amount: 50, symbolOverride: '€'),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.data, contains('€'));
    });

    testWidgets('currency code override works', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoCurrency(
            amount: 100,
            currencyCodeOverride: 'GBP',
            symbolOverride: '£',
          ),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.data, contains('£'));
    });

    testWidgets('applies text style', (tester) async {
      const style = TextStyle(fontSize: 18, color: Colors.green);
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoCurrency(amount: 10, textStyle: style),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 18);
      expect(text.style?.color, Colors.green);
    });
  });
}
