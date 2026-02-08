import 'dart:ui' show Locale;

/// Utilities for working with locale strings and [Locale] objects.
class LocaleUtils {
  LocaleUtils._();

  /// Converts a locale string like 'en_US' or 'en' into a [Locale].
  static Locale parseLocale(String localeString) {
    final parts = localeString.split('_');
    if (parts.length >= 2) {
      return Locale(parts[0], parts[1]);
    }
    return Locale(parts[0]);
  }

  /// Converts a [Locale] to a string like 'en_US' or 'en'.
  static String localeToString(Locale locale) {
    if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
      return '${locale.languageCode}_${locale.countryCode}';
    }
    return locale.languageCode;
  }
}
