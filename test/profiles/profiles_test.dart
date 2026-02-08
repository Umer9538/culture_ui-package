import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

void main() {
  group('CultureProfiles', () {
    test('all contains 12 profiles', () {
      expect(CultureProfiles.all.length, 12);
    });

    test('all profiles have unique IDs', () {
      final ids = CultureProfiles.all.map((p) => p.id).toSet();
      expect(ids.length, CultureProfiles.all.length);
    });

    test('all profiles have at least one locale', () {
      for (final profile in CultureProfiles.all) {
        expect(
          profile.locales,
          isNotEmpty,
          reason: '${profile.id} has no locales',
        );
      }
    });

    test('all profiles have a display name', () {
      for (final profile in CultureProfiles.all) {
        expect(
          profile.displayName,
          isNotEmpty,
          reason: '${profile.id} has no displayName',
        );
      }
    });

    test('all profiles have at least some color semantics', () {
      for (final profile in CultureProfiles.all) {
        expect(
          profile.colorSemantics,
          isNotEmpty,
          reason: '${profile.id} has no colorSemantics',
        );
      }
    });

    test('arabic profile is RTL', () {
      expect(CultureProfiles.arabic.readingPattern, ReadingPattern.rtl);
    });

    test('japanese profile uses emphasis dots', () {
      expect(
        CultureProfiles.japanese.textEmphasisStyle,
        TextEmphasisStyle.emphasisDots,
      );
    });

    test('japanese profile uses compact density', () {
      expect(CultureProfiles.japanese.layoutDensity, LayoutDensity.compact);
    });

    test('arabic profile uses comfortable density', () {
      expect(CultureProfiles.arabic.layoutDensity, LayoutDensity.comfortable);
    });

    test('japanese profile expects family name first', () {
      expect(
        CultureProfiles.japanese.nameInputExpectsFamily,
        NameOrder.familyFirst,
      );
    });

    test('chinese profile expects family name first', () {
      expect(
        CultureProfiles.chinese.nameInputExpectsFamily,
        NameOrder.familyFirst,
      );
    });

    test('korean profile expects family name first', () {
      expect(
        CultureProfiles.korean.nameInputExpectsFamily,
        NameOrder.familyFirst,
      );
    });

    test('american profile expects given name first', () {
      expect(
        CultureProfiles.american.nameInputExpectsFamily,
        NameOrder.givenFirst,
      );
    });

    test('japanese currency has 0 decimal digits', () {
      expect(CultureProfiles.japanese.currencyDecimalDigits, 0);
    });

    test('korean currency has 0 decimal digits', () {
      expect(CultureProfiles.korean.currencyDecimalDigits, 0);
    });

    test('german uses 24-hour time', () {
      expect(CultureProfiles.german.uses24HourTime, true);
    });

    test('american uses 12-hour time', () {
      expect(CultureProfiles.american.uses24HourTime, false);
    });

    test('arabic primary button is on the left', () {
      expect(
        CultureProfiles.arabic.primaryButtonPosition,
        PrimaryButtonPosition.left,
      );
    });

    test('french dialog order is confirm-left', () {
      expect(
        CultureProfiles.french.dialogButtonOrder,
        DialogButtonOrder.confirmLeft,
      );
    });

    test('german currency is EUR', () {
      expect(CultureProfiles.german.currencyCode, 'EUR');
      expect(CultureProfiles.german.currencySymbol, '€');
      expect(
        CultureProfiles.german.currencySymbolPosition,
        CurrencySymbolPosition.after,
      );
    });

    test('indian number locale is en_IN', () {
      expect(CultureProfiles.indian.numberLocale, 'en_IN');
    });
  });
}
