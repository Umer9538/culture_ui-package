import 'package:flutter/material.dart';

import '../core/culture_profile.dart';
import '../core/enums.dart';

/// Container for all built-in culture profiles.
///
/// Access profiles as static constants:
/// ```dart
/// CultureProfiles.japanese
/// CultureProfiles.arabic
/// CultureProfiles.american
/// ```
class CultureProfiles {
  CultureProfiles._();

  // ──────────────────────────────────────────
  // American English (en_US)
  // ──────────────────────────────────────────
  static const CultureProfile american = CultureProfile(
    id: 'american',
    locales: ['en_US', 'en'],
    displayName: 'American English',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.bold,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'MM/dd/yyyy',
    shortDatePattern: 'M/d/yy',
    longDatePattern: 'MMMM d, yyyy',
    timeFormatPattern: 'h:mm a',
    uses24HourTime: false,
    currencyCode: 'USD',
    currencySymbol: r'$',
    currencySymbolPosition: CurrencySymbolPosition.before,
    currencyDecimalDigits: 2,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmRight,
    layoutDensity: LayoutDensity.normal,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.warning: Color(0xFFF57C00),
      ColorSemantic.info: Color(0xFF1976D2),
      ColorSemantic.mourning: Color(0xFF212121),
      ColorSemantic.purity: Color(0xFFFFFFFF),
      ColorSemantic.love: Color(0xFFE91E63),
    },
    nameInputExpectsFamily: NameOrder.givenFirst,
    postalCodePattern: r'^\d{5}(-\d{4})?$',
    phoneNumberPattern: r'^\+?1?\d{10}$',
  );

  // ──────────────────────────────────────────
  // British English (en_GB)
  // ──────────────────────────────────────────
  static const CultureProfile british = CultureProfile(
    id: 'british',
    locales: ['en_GB'],
    displayName: 'British English',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.bold,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'dd/MM/yyyy',
    shortDatePattern: 'd/M/yy',
    longDatePattern: 'd MMMM yyyy',
    timeFormatPattern: 'HH:mm',
    uses24HourTime: true,
    currencyCode: 'GBP',
    currencySymbol: '£',
    currencySymbolPosition: CurrencySymbolPosition.before,
    currencyDecimalDigits: 2,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmRight,
    layoutDensity: LayoutDensity.normal,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.warning: Color(0xFFF57C00),
      ColorSemantic.info: Color(0xFF1976D2),
      ColorSemantic.mourning: Color(0xFF212121),
      ColorSemantic.purity: Color(0xFFFFFFFF),
      ColorSemantic.love: Color(0xFFE91E63),
    },
    nameInputExpectsFamily: NameOrder.givenFirst,
    postalCodePattern: r'^[A-Z]{1,2}\d[A-Z\d]?\s?\d[A-Z]{2}$',
    phoneNumberPattern: r'^\+?44\d{10}$',
  );

  // ──────────────────────────────────────────
  // Arabic (ar)
  // ──────────────────────────────────────────
  static const CultureProfile arabic = CultureProfile(
    id: 'arabic',
    locales: ['ar', 'ar_SA', 'ar_EG', 'ar_AE'],
    displayName: 'Arabic',
    readingPattern: ReadingPattern.rtl,
    textEmphasisStyle: TextEmphasisStyle.bold,
    truncationDirection: TruncationDirection.start,
    dateFormatPattern: 'dd/MM/yyyy',
    shortDatePattern: 'd/M/yy',
    longDatePattern: 'dd MMMM yyyy',
    timeFormatPattern: 'h:mm a',
    uses24HourTime: false,
    currencyCode: 'SAR',
    currencySymbol: 'ر.س',
    currencySymbolPosition: CurrencySymbolPosition.after,
    currencyDecimalDigits: 2,
    primaryButtonPosition: PrimaryButtonPosition.left,
    dialogButtonOrder: DialogButtonOrder.confirmLeft,
    layoutDensity: LayoutDensity.comfortable,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF2E7D32),
      ColorSemantic.warning: Color(0xFFF57C00),
      ColorSemantic.info: Color(0xFF1976D2),
      ColorSemantic.mourning: Color(0xFF212121),
      ColorSemantic.purity: Color(0xFF2E7D32),
    },
    nameInputExpectsFamily: NameOrder.givenFirst,
  );

  // ──────────────────────────────────────────
  // Japanese (ja)
  // ──────────────────────────────────────────
  static const CultureProfile japanese = CultureProfile(
    id: 'japanese',
    locales: ['ja', 'ja_JP'],
    displayName: 'Japanese',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.emphasisDots,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'yyyy/MM/dd',
    shortDatePattern: 'yy/M/d',
    longDatePattern: "yyyy'年'MM'月'dd'日'",
    timeFormatPattern: 'H:mm',
    uses24HourTime: true,
    currencyCode: 'JPY',
    currencySymbol: '¥',
    currencySymbolPosition: CurrencySymbolPosition.before,
    currencyDecimalDigits: 0,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmRight,
    layoutDensity: LayoutDensity.compact,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.luck: Color(0xFFD32F2F),
      ColorSemantic.mourning: Color(0xFF212121),
      ColorSemantic.purity: Color(0xFFFFFFFF),
      ColorSemantic.celebration: Color(0xFFD32F2F),
    },
    nameInputExpectsFamily: NameOrder.familyFirst,
    postalCodePattern: r'^\d{3}-\d{4}$',
    phoneNumberPattern: r'^\+?81\d{9,10}$',
  );

  // ──────────────────────────────────────────
  // German (de)
  // ──────────────────────────────────────────
  static const CultureProfile german = CultureProfile(
    id: 'german',
    locales: ['de', 'de_DE'],
    displayName: 'German',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.bold,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'dd.MM.yyyy',
    shortDatePattern: 'd.M.yy',
    longDatePattern: 'd. MMMM yyyy',
    timeFormatPattern: 'HH:mm',
    uses24HourTime: true,
    currencyCode: 'EUR',
    currencySymbol: '€',
    currencySymbolPosition: CurrencySymbolPosition.after,
    currencyDecimalDigits: 2,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmRight,
    layoutDensity: LayoutDensity.normal,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.warning: Color(0xFFF57C00),
      ColorSemantic.info: Color(0xFF1976D2),
      ColorSemantic.mourning: Color(0xFF212121),
      ColorSemantic.purity: Color(0xFFFFFFFF),
    },
    nameInputExpectsFamily: NameOrder.givenFirst,
    postalCodePattern: r'^\d{5}$',
    phoneNumberPattern: r'^\+?49\d{10,11}$',
  );

  // ──────────────────────────────────────────
  // Indian (hi / en_IN)
  // ──────────────────────────────────────────
  static const CultureProfile indian = CultureProfile(
    id: 'indian',
    locales: ['hi', 'en_IN'],
    displayName: 'Indian',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.bold,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'dd/MM/yyyy',
    shortDatePattern: 'd/M/yy',
    longDatePattern: 'd MMMM yyyy',
    timeFormatPattern: 'h:mm a',
    uses24HourTime: false,
    numberLocale: 'en_IN',
    currencyCode: 'INR',
    currencySymbol: '₹',
    currencySymbolPosition: CurrencySymbolPosition.before,
    currencyDecimalDigits: 2,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmRight,
    layoutDensity: LayoutDensity.normal,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.warning: Color(0xFFF57C00),
      ColorSemantic.luck: Color(0xFFD32F2F),
      ColorSemantic.mourning: Color(0xFFFFFFFF),
      ColorSemantic.purity: Color(0xFFFFFFFF),
      ColorSemantic.celebration: Color(0xFFD32F2F),
      ColorSemantic.wealth: Color(0xFFFFD700),
    },
    nameInputExpectsFamily: NameOrder.givenFirst,
    postalCodePattern: r'^\d{6}$',
    phoneNumberPattern: r'^\+?91\d{10}$',
  );

  // ──────────────────────────────────────────
  // Chinese (zh)
  // ──────────────────────────────────────────
  static const CultureProfile chinese = CultureProfile(
    id: 'chinese',
    locales: ['zh', 'zh_CN'],
    displayName: 'Chinese',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.emphasisDots,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'yyyy/MM/dd',
    shortDatePattern: 'yy/M/d',
    longDatePattern: "yyyy'年'MM'月'dd'日'",
    timeFormatPattern: 'HH:mm',
    uses24HourTime: true,
    currencyCode: 'CNY',
    currencySymbol: '¥',
    currencySymbolPosition: CurrencySymbolPosition.before,
    currencyDecimalDigits: 2,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmRight,
    layoutDensity: LayoutDensity.compact,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.luck: Color(0xFFD32F2F),
      ColorSemantic.mourning: Color(0xFFFFFFFF),
      ColorSemantic.celebration: Color(0xFFD32F2F),
      ColorSemantic.wealth: Color(0xFFFFD700),
      ColorSemantic.authority: Color(0xFFFFD700),
    },
    nameInputExpectsFamily: NameOrder.familyFirst,
    postalCodePattern: r'^\d{6}$',
    phoneNumberPattern: r'^\+?86\d{11}$',
  );

  // ──────────────────────────────────────────
  // French (fr)
  // ──────────────────────────────────────────
  static const CultureProfile french = CultureProfile(
    id: 'french',
    locales: ['fr', 'fr_FR'],
    displayName: 'French',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.bold,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'dd/MM/yyyy',
    shortDatePattern: 'd/M/yy',
    longDatePattern: 'd MMMM yyyy',
    timeFormatPattern: 'HH:mm',
    uses24HourTime: true,
    currencyCode: 'EUR',
    currencySymbol: '€',
    currencySymbolPosition: CurrencySymbolPosition.after,
    currencyDecimalDigits: 2,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmLeft,
    layoutDensity: LayoutDensity.normal,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.warning: Color(0xFFF57C00),
      ColorSemantic.info: Color(0xFF1976D2),
      ColorSemantic.mourning: Color(0xFF212121),
      ColorSemantic.purity: Color(0xFFFFFFFF),
      ColorSemantic.love: Color(0xFFE91E63),
    },
    nameInputExpectsFamily: NameOrder.givenFirst,
    postalCodePattern: r'^\d{5}$',
    phoneNumberPattern: r'^\+?33\d{9}$',
  );

  // ──────────────────────────────────────────
  // Korean (ko)
  // ──────────────────────────────────────────
  static const CultureProfile korean = CultureProfile(
    id: 'korean',
    locales: ['ko', 'ko_KR'],
    displayName: 'Korean',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.bold,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'yyyy.MM.dd',
    shortDatePattern: 'yy.M.d',
    longDatePattern: "yyyy'년' MM'월' dd'일'",
    timeFormatPattern: 'a h:mm',
    uses24HourTime: false,
    currencyCode: 'KRW',
    currencySymbol: '₩',
    currencySymbolPosition: CurrencySymbolPosition.before,
    currencyDecimalDigits: 0,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmRight,
    layoutDensity: LayoutDensity.compact,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.luck: Color(0xFFD32F2F),
      ColorSemantic.mourning: Color(0xFF212121),
      ColorSemantic.purity: Color(0xFFFFFFFF),
    },
    nameInputExpectsFamily: NameOrder.familyFirst,
    postalCodePattern: r'^\d{5}$',
    phoneNumberPattern: r'^\+?82\d{9,10}$',
  );

  // ──────────────────────────────────────────
  // Brazilian Portuguese (pt_BR)
  // ──────────────────────────────────────────
  static const CultureProfile brazilian = CultureProfile(
    id: 'brazilian',
    locales: ['pt_BR', 'pt'],
    displayName: 'Brazilian Portuguese',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.bold,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'dd/MM/yyyy',
    shortDatePattern: 'd/M/yy',
    longDatePattern: "d 'de' MMMM 'de' yyyy",
    timeFormatPattern: 'HH:mm',
    uses24HourTime: true,
    currencyCode: 'BRL',
    currencySymbol: r'R$',
    currencySymbolPosition: CurrencySymbolPosition.before,
    currencyDecimalDigits: 2,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmRight,
    layoutDensity: LayoutDensity.normal,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.warning: Color(0xFFF57C00),
      ColorSemantic.mourning: Color(0xFF212121),
      ColorSemantic.purity: Color(0xFFFFFFFF),
      ColorSemantic.celebration: Color(0xFF4CAF50),
    },
    nameInputExpectsFamily: NameOrder.givenFirst,
    postalCodePattern: r'^\d{5}-?\d{3}$',
    phoneNumberPattern: r'^\+?55\d{10,11}$',
  );

  // ──────────────────────────────────────────
  // Spanish (es)
  // ──────────────────────────────────────────
  static const CultureProfile spanish = CultureProfile(
    id: 'spanish',
    locales: ['es', 'es_ES'],
    displayName: 'Spanish',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.bold,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'dd/MM/yyyy',
    shortDatePattern: 'd/M/yy',
    longDatePattern: "d 'de' MMMM 'de' yyyy",
    timeFormatPattern: 'HH:mm',
    uses24HourTime: true,
    currencyCode: 'EUR',
    currencySymbol: '€',
    currencySymbolPosition: CurrencySymbolPosition.after,
    currencyDecimalDigits: 2,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmRight,
    layoutDensity: LayoutDensity.normal,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.warning: Color(0xFFF57C00),
      ColorSemantic.info: Color(0xFF1976D2),
      ColorSemantic.mourning: Color(0xFF212121),
      ColorSemantic.purity: Color(0xFFFFFFFF),
      ColorSemantic.love: Color(0xFFE91E63),
    },
    nameInputExpectsFamily: NameOrder.givenFirst,
    postalCodePattern: r'^\d{5}$',
    phoneNumberPattern: r'^\+?34\d{9}$',
  );

  // ──────────────────────────────────────────
  // Russian (ru)
  // ──────────────────────────────────────────
  static const CultureProfile russian = CultureProfile(
    id: 'russian',
    locales: ['ru', 'ru_RU'],
    displayName: 'Russian',
    readingPattern: ReadingPattern.ltr,
    textEmphasisStyle: TextEmphasisStyle.bold,
    truncationDirection: TruncationDirection.end,
    dateFormatPattern: 'dd.MM.yyyy',
    shortDatePattern: 'd.M.yy',
    longDatePattern: 'd MMMM yyyy',
    timeFormatPattern: 'HH:mm',
    uses24HourTime: true,
    currencyCode: 'RUB',
    currencySymbol: '₽',
    currencySymbolPosition: CurrencySymbolPosition.after,
    currencyDecimalDigits: 2,
    primaryButtonPosition: PrimaryButtonPosition.right,
    dialogButtonOrder: DialogButtonOrder.confirmRight,
    layoutDensity: LayoutDensity.normal,
    formLayoutPreference: FormLayoutPreference.labelAbove,
    colorSemantics: {
      ColorSemantic.danger: Color(0xFFD32F2F),
      ColorSemantic.success: Color(0xFF388E3C),
      ColorSemantic.warning: Color(0xFFF57C00),
      ColorSemantic.info: Color(0xFF1976D2),
      ColorSemantic.mourning: Color(0xFF212121),
      ColorSemantic.purity: Color(0xFFFFFFFF),
    },
    nameInputExpectsFamily: NameOrder.givenFirst,
    postalCodePattern: r'^\d{6}$',
    phoneNumberPattern: r'^\+?7\d{10}$',
  );

  /// All built-in profiles.
  static const List<CultureProfile> all = [
    american,
    british,
    arabic,
    japanese,
    german,
    indian,
    chinese,
    french,
    korean,
    brazilian,
    spanish,
    russian,
  ];
}
