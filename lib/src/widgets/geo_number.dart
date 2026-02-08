import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../core/culture_provider.dart';

/// Formats a number according to the current culture profile.
///
/// Handles decimal separators, grouping separators, and digit grouping
/// patterns automatically.
///
/// ```dart
/// GeoNumber(value: 1234567.89)
/// // American: 1,234,567.89
/// // German:   1.234.567,89
/// // Indian:   12,34,567.89
///
/// GeoNumber(value: 1234567, compact: true)
/// // American: 1.2M
/// // Japanese: 123万
/// ```
class GeoNumber extends StatelessWidget {
  /// Creates a culture-aware number display widget.
  const GeoNumber({
    super.key,
    required this.value,
    this.decimalDigits,
    this.textStyle,
    this.compact = false,
  });

  /// The number to display.
  final num value;

  /// Fixed number of decimal digits. If null, uses default formatting.
  final int? decimalDigits;

  /// Optional text style for the displayed number.
  final TextStyle? textStyle;

  /// Whether to use compact notation (e.g., 1.2M instead of 1,200,000).
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final profile = CultureScope.of(context);
    final String formatted;

    if (compact) {
      formatted = NumberFormat.compact(
        locale: profile.effectiveLocale,
      ).format(value);
    } else {
      final formatter = NumberFormat.decimalPattern(profile.effectiveLocale);
      if (decimalDigits != null) {
        formatter.minimumFractionDigits = decimalDigits!;
        formatter.maximumFractionDigits = decimalDigits!;
      }
      formatted = formatter.format(value);
    }

    return Text(formatted, style: textStyle);
  }
}
