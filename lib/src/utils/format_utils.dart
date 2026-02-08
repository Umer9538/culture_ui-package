import 'package:intl/intl.dart';

import '../core/culture_profile.dart';

/// Formatting helpers that wrap the [intl] package using [CultureProfile] config.
class FormatUtils {
  FormatUtils._();

  /// Formats a [DateTime] using the profile's date format pattern.
  static String formatDate(
    DateTime date,
    CultureProfile profile, {
    String? pattern,
  }) {
    final effectivePattern = pattern ?? profile.dateFormatPattern;
    return DateFormat(effectivePattern, profile.effectiveLocale).format(date);
  }

  /// Formats a [num] using the profile's locale for grouping/decimal separators.
  static String formatNumber(
    num value,
    CultureProfile profile, {
    int? decimalDigits,
    bool compact = false,
  }) {
    if (compact) {
      return NumberFormat.compact(
        locale: profile.effectiveLocale,
      ).format(value);
    }
    final formatter = NumberFormat.decimalPattern(profile.effectiveLocale);
    if (decimalDigits != null) {
      formatter.minimumFractionDigits = decimalDigits;
      formatter.maximumFractionDigits = decimalDigits;
    }
    return formatter.format(value);
  }

  /// Formats a [num] as currency using the profile's currency config.
  static String formatCurrency(
    num amount,
    CultureProfile profile, {
    String? currencyCode,
    String? symbol,
  }) {
    return NumberFormat.currency(
      locale: profile.effectiveLocale,
      name: currencyCode ?? profile.currencyCode,
      symbol: symbol ?? profile.currencySymbol,
      decimalDigits: profile.currencyDecimalDigits,
    ).format(amount);
  }

  /// Formats a [DateTime] as time using the profile's time format.
  static String formatTime(DateTime time, CultureProfile profile) {
    return DateFormat(
      profile.timeFormatPattern,
      profile.effectiveLocale,
    ).format(time);
  }
}
