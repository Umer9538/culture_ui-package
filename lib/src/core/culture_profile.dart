import 'package:flutter/material.dart';

import 'enums.dart';

/// An immutable data class that holds all cultural behavior configuration.
///
/// Similar to [ThemeData], this class defines how UI should behave for a
/// specific culture. Each instance maps to one or more locales and contains
/// configuration for text behavior, date/number/currency formatting,
/// layout preferences, color semantics, and form patterns.
///
/// Use the built-in profiles from [CultureProfiles] or create your own:
///
/// ```dart
/// const myProfile = CultureProfile(
///   id: 'thai',
///   locales: ['th', 'th_TH'],
///   displayName: 'Thai',
/// );
/// ```
@immutable
class CultureProfile {
  /// Creates a new culture profile with the given configuration.
  const CultureProfile({
    required this.id,
    required this.locales,
    required this.displayName,
    this.readingPattern = ReadingPattern.ltr,
    this.textEmphasisStyle = TextEmphasisStyle.bold,
    this.truncationDirection = TruncationDirection.end,
    this.dateFormatPattern = 'MM/dd/yyyy',
    this.shortDatePattern = 'M/d/yy',
    this.longDatePattern = 'MMMM d, yyyy',
    this.timeFormatPattern = 'h:mm a',
    this.uses24HourTime = false,
    this.numberLocale,
    this.currencyCode = 'USD',
    this.currencySymbol = r'$',
    this.currencySymbolPosition = CurrencySymbolPosition.before,
    this.currencyDecimalDigits = 2,
    this.primaryButtonPosition = PrimaryButtonPosition.right,
    this.dialogButtonOrder = DialogButtonOrder.confirmRight,
    this.layoutDensity = LayoutDensity.normal,
    this.formLayoutPreference = FormLayoutPreference.labelAbove,
    this.defaultPadding = const EdgeInsets.all(16.0),
    this.compactPadding = const EdgeInsets.all(8.0),
    this.comfortablePadding = const EdgeInsets.all(24.0),
    this.colorSemantics = const {},
    this.nameInputExpectsFamily = NameOrder.givenFirst,
    this.postalCodePattern,
    this.phoneNumberPattern,
    this.iconOverrides = const {},
  });

  /// Unique identifier for this profile (e.g., 'american', 'japanese').
  final String id;

  /// Locale codes this profile applies to (e.g., ['en_US', 'en']).
  /// The first entry is the primary/preferred locale.
  final List<String> locales;

  /// Human-readable name (e.g., 'American English', 'Japanese').
  final String displayName;

  // --- Text Behavior ---

  /// The reading direction pattern for this culture.
  final ReadingPattern readingPattern;

  /// How text emphasis is typically shown in this culture.
  final TextEmphasisStyle textEmphasisStyle;

  /// Direction from which text is truncated when overflowing.
  final TruncationDirection truncationDirection;

  // --- Date/Time Formatting ---

  /// Default date format pattern (e.g., 'MM/dd/yyyy').
  final String dateFormatPattern;

  /// Short date format pattern (e.g., 'M/d/yy').
  final String shortDatePattern;

  /// Long date format pattern (e.g., 'MMMM d, yyyy').
  final String longDatePattern;

  /// Time format pattern (e.g., 'h:mm a' or 'HH:mm').
  final String timeFormatPattern;

  /// Whether this culture prefers 24-hour time.
  final bool uses24HourTime;

  // --- Number Formatting ---

  /// Locale string for [intl] NumberFormat. Falls back to [locales].first.
  final String? numberLocale;

  // --- Currency ---

  /// ISO 4217 currency code (e.g., 'USD', 'JPY', 'EUR').
  final String currencyCode;

  /// Currency symbol (e.g., '\$', '¥', '€').
  final String currencySymbol;

  /// Whether the currency symbol appears before or after the amount.
  final CurrencySymbolPosition currencySymbolPosition;

  /// Number of decimal digits for currency (e.g., 2 for USD, 0 for JPY).
  final int currencyDecimalDigits;

  // --- Layout & Interaction ---

  /// Where the primary action button appears in a button row.
  final PrimaryButtonPosition primaryButtonPosition;

  /// Order of confirm/cancel buttons in dialogs.
  final DialogButtonOrder dialogButtonOrder;

  /// UI density preference affecting spacing and padding.
  final LayoutDensity layoutDensity;

  /// Preferred form field layout style.
  final FormLayoutPreference formLayoutPreference;

  /// Padding for normal layout density.
  final EdgeInsets defaultPadding;

  /// Padding for compact layout density.
  final EdgeInsets compactPadding;

  /// Padding for comfortable layout density.
  final EdgeInsets comfortablePadding;

  // --- Color Semantics ---

  /// Maps semantic meanings to colors for this culture.
  final Map<ColorSemantic, Color> colorSemantics;

  // --- Form Preferences ---

  /// Expected order of name components in name input fields.
  final NameOrder nameInputExpectsFamily;

  /// Regex pattern for validating postal codes (null = no validation).
  final String? postalCodePattern;

  /// Regex pattern for validating phone numbers (null = no validation).
  final String? phoneNumberPattern;

  // --- Icon Overrides ---

  /// Maps semantic icon keys to culture-specific [IconData].
  final Map<String, IconData> iconOverrides;

  /// The effective locale string for intl formatting.
  String get effectiveLocale => numberLocale ?? locales.first;

  /// Returns the [EdgeInsets] appropriate for the current [layoutDensity].
  EdgeInsets get densityPadding {
    switch (layoutDensity) {
      case LayoutDensity.compact:
        return compactPadding;
      case LayoutDensity.normal:
        return defaultPadding;
      case LayoutDensity.comfortable:
        return comfortablePadding;
    }
  }

  /// Creates a copy of this profile with the given fields replaced.
  CultureProfile copyWith({
    String? id,
    List<String>? locales,
    String? displayName,
    ReadingPattern? readingPattern,
    TextEmphasisStyle? textEmphasisStyle,
    TruncationDirection? truncationDirection,
    String? dateFormatPattern,
    String? shortDatePattern,
    String? longDatePattern,
    String? timeFormatPattern,
    bool? uses24HourTime,
    String? numberLocale,
    String? currencyCode,
    String? currencySymbol,
    CurrencySymbolPosition? currencySymbolPosition,
    int? currencyDecimalDigits,
    PrimaryButtonPosition? primaryButtonPosition,
    DialogButtonOrder? dialogButtonOrder,
    LayoutDensity? layoutDensity,
    FormLayoutPreference? formLayoutPreference,
    EdgeInsets? defaultPadding,
    EdgeInsets? compactPadding,
    EdgeInsets? comfortablePadding,
    Map<ColorSemantic, Color>? colorSemantics,
    NameOrder? nameInputExpectsFamily,
    String? postalCodePattern,
    String? phoneNumberPattern,
    Map<String, IconData>? iconOverrides,
  }) {
    return CultureProfile(
      id: id ?? this.id,
      locales: locales ?? this.locales,
      displayName: displayName ?? this.displayName,
      readingPattern: readingPattern ?? this.readingPattern,
      textEmphasisStyle: textEmphasisStyle ?? this.textEmphasisStyle,
      truncationDirection: truncationDirection ?? this.truncationDirection,
      dateFormatPattern: dateFormatPattern ?? this.dateFormatPattern,
      shortDatePattern: shortDatePattern ?? this.shortDatePattern,
      longDatePattern: longDatePattern ?? this.longDatePattern,
      timeFormatPattern: timeFormatPattern ?? this.timeFormatPattern,
      uses24HourTime: uses24HourTime ?? this.uses24HourTime,
      numberLocale: numberLocale ?? this.numberLocale,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencySymbolPosition:
          currencySymbolPosition ?? this.currencySymbolPosition,
      currencyDecimalDigits:
          currencyDecimalDigits ?? this.currencyDecimalDigits,
      primaryButtonPosition:
          primaryButtonPosition ?? this.primaryButtonPosition,
      dialogButtonOrder: dialogButtonOrder ?? this.dialogButtonOrder,
      layoutDensity: layoutDensity ?? this.layoutDensity,
      formLayoutPreference: formLayoutPreference ?? this.formLayoutPreference,
      defaultPadding: defaultPadding ?? this.defaultPadding,
      compactPadding: compactPadding ?? this.compactPadding,
      comfortablePadding: comfortablePadding ?? this.comfortablePadding,
      colorSemantics: colorSemantics ?? this.colorSemantics,
      nameInputExpectsFamily:
          nameInputExpectsFamily ?? this.nameInputExpectsFamily,
      postalCodePattern: postalCodePattern ?? this.postalCodePattern,
      phoneNumberPattern: phoneNumberPattern ?? this.phoneNumberPattern,
      iconOverrides: iconOverrides ?? this.iconOverrides,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CultureProfile &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CultureProfile($id)';
}
