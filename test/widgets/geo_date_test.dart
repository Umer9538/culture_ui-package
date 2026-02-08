import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  final testDate = DateTime(2026, 2, 8, 14, 30);

  group('GeoDate', () {
    testWidgets('formats date in American style (MM/dd/yyyy)', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoDate(date: testDate),
          profile: CultureProfiles.american,
        ),
      );
      expect(find.text('02/08/2026'), findsOneWidget);
    });

    testWidgets('formats date in German style (dd.MM.yyyy)', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoDate(date: testDate),
          profile: CultureProfiles.german,
        ),
      );
      expect(find.text('08.02.2026'), findsOneWidget);
    });

    testWidgets('formats date in Japanese style (yyyy/MM/dd)', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoDate(date: testDate),
          profile: CultureProfiles.japanese,
        ),
      );
      expect(find.text('2026/02/08'), findsOneWidget);
    });

    testWidgets('formats date in British style (dd/MM/yyyy)', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoDate(date: testDate),
          profile: CultureProfiles.british,
        ),
      );
      expect(find.text('08/02/2026'), findsOneWidget);
    });

    testWidgets('formats date in Korean style (yyyy.MM.dd)', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoDate(date: testDate),
          profile: CultureProfiles.korean,
        ),
      );
      expect(find.text('2026.02.08'), findsOneWidget);
    });

    testWidgets('short style uses short pattern', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoDate(date: testDate, style: GeoDateStyle.short),
          profile: CultureProfiles.american,
        ),
      );
      expect(find.text('2/8/26'), findsOneWidget);
    });

    testWidgets('custom pattern overrides style', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoDate(date: testDate, customPattern: 'yyyy-MM-dd'),
          profile: CultureProfiles.american,
        ),
      );
      expect(find.text('2026-02-08'), findsOneWidget);
    });

    testWidgets('applies text style', (tester) async {
      const style = TextStyle(fontSize: 24, color: Colors.red);
      await tester.pumpWidget(
        wrapWithCulture(
          GeoDate(date: testDate, textStyle: style),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 24);
      expect(text.style?.color, Colors.red);
    });

    testWidgets('includeTime appends time', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          GeoDate(date: testDate, includeTime: true),
          profile: CultureProfiles.american,
        ),
      );
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.data, contains('02/08/2026'));
      expect(text.data, contains('2:30 PM'));
    });
  });
}
