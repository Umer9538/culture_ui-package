import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

void main() {
  group('CultureProfile', () {
    test('effectiveLocale returns numberLocale when set', () {
      const profile = CultureProfile(
        id: 'test',
        locales: ['en_US'],
        displayName: 'Test',
        numberLocale: 'en_IN',
      );
      expect(profile.effectiveLocale, 'en_IN');
    });

    test('effectiveLocale falls back to first locale', () {
      const profile = CultureProfile(
        id: 'test',
        locales: ['ja', 'ja_JP'],
        displayName: 'Test',
      );
      expect(profile.effectiveLocale, 'ja');
    });

    test('densityPadding returns correct padding for compact', () {
      const profile = CultureProfile(
        id: 'test',
        locales: ['ja'],
        displayName: 'Test',
        layoutDensity: LayoutDensity.compact,
        compactPadding: EdgeInsets.all(4.0),
      );
      expect(profile.densityPadding, const EdgeInsets.all(4.0));
    });

    test('densityPadding returns correct padding for normal', () {
      const profile = CultureProfile(
        id: 'test',
        locales: ['en'],
        displayName: 'Test',
        layoutDensity: LayoutDensity.normal,
        defaultPadding: EdgeInsets.all(16.0),
      );
      expect(profile.densityPadding, const EdgeInsets.all(16.0));
    });

    test('densityPadding returns correct padding for comfortable', () {
      const profile = CultureProfile(
        id: 'test',
        locales: ['ar'],
        displayName: 'Test',
        layoutDensity: LayoutDensity.comfortable,
        comfortablePadding: EdgeInsets.all(32.0),
      );
      expect(profile.densityPadding, const EdgeInsets.all(32.0));
    });

    test('copyWith creates a new profile with replaced fields', () {
      const original = CultureProfile(
        id: 'original',
        locales: ['en'],
        displayName: 'Original',
        dateFormatPattern: 'MM/dd/yyyy',
      );

      final copy = original.copyWith(
        id: 'copy',
        dateFormatPattern: 'dd/MM/yyyy',
      );

      expect(copy.id, 'copy');
      expect(copy.dateFormatPattern, 'dd/MM/yyyy');
      // Unchanged fields preserved
      expect(copy.locales, ['en']);
      expect(copy.displayName, 'Original');
    });

    test('copyWith preserves all fields when no arguments given', () {
      const original = CultureProfile(
        id: 'test',
        locales: ['fr'],
        displayName: 'French',
        readingPattern: ReadingPattern.ltr,
        currencyCode: 'EUR',
        layoutDensity: LayoutDensity.normal,
      );

      final copy = original.copyWith();

      expect(copy.id, original.id);
      expect(copy.locales, original.locales);
      expect(copy.displayName, original.displayName);
      expect(copy.readingPattern, original.readingPattern);
      expect(copy.currencyCode, original.currencyCode);
      expect(copy.layoutDensity, original.layoutDensity);
    });

    test('equality is based on id', () {
      const profile1 = CultureProfile(
        id: 'same',
        locales: ['en'],
        displayName: 'One',
      );
      const profile2 = CultureProfile(
        id: 'same',
        locales: ['fr'],
        displayName: 'Two',
      );
      const profile3 = CultureProfile(
        id: 'different',
        locales: ['en'],
        displayName: 'Three',
      );

      expect(profile1, equals(profile2));
      expect(profile1, isNot(equals(profile3)));
    });

    test('hashCode is based on id', () {
      const profile1 = CultureProfile(
        id: 'same',
        locales: ['en'],
        displayName: 'One',
      );
      const profile2 = CultureProfile(
        id: 'same',
        locales: ['fr'],
        displayName: 'Two',
      );

      expect(profile1.hashCode, equals(profile2.hashCode));
    });

    test('toString returns readable representation', () {
      const profile = CultureProfile(
        id: 'american',
        locales: ['en_US'],
        displayName: 'American',
      );
      expect(profile.toString(), 'CultureProfile(american)');
    });

    test('default values are correct', () {
      const profile = CultureProfile(
        id: 'test',
        locales: ['en'],
        displayName: 'Test',
      );

      expect(profile.readingPattern, ReadingPattern.ltr);
      expect(profile.textEmphasisStyle, TextEmphasisStyle.bold);
      expect(profile.truncationDirection, TruncationDirection.end);
      expect(profile.dateFormatPattern, 'MM/dd/yyyy');
      expect(profile.uses24HourTime, false);
      expect(profile.currencyCode, 'USD');
      expect(profile.currencySymbolPosition, CurrencySymbolPosition.before);
      expect(profile.currencyDecimalDigits, 2);
      expect(profile.primaryButtonPosition, PrimaryButtonPosition.right);
      expect(profile.dialogButtonOrder, DialogButtonOrder.confirmRight);
      expect(profile.layoutDensity, LayoutDensity.normal);
      expect(profile.formLayoutPreference, FormLayoutPreference.labelAbove);
      expect(profile.nameInputExpectsFamily, NameOrder.givenFirst);
      expect(profile.colorSemantics, isEmpty);
      expect(profile.iconOverrides, isEmpty);
      expect(profile.postalCodePattern, isNull);
      expect(profile.phoneNumberPattern, isNull);
    });
  });
}
