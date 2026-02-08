import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../core/culture_provider.dart';
import '../core/culture_profile.dart';

/// The display style for [GeoDate].
enum GeoDateStyle {
  /// Short format (e.g., '2/8/26').
  short,

  /// Medium/default format (e.g., '02/08/2026').
  medium,

  /// Long format (e.g., 'February 8, 2026').
  long,
}

/// Displays a [DateTime] formatted according to the current culture profile.
///
/// Unlike using [DateFormat] directly, this widget automatically adapts to
/// the cultural context without requiring locale-specific format strings.
///
/// ```dart
/// GeoDate(date: DateTime.now())
/// // American: 02/08/2026
/// // Japanese: 2026/02/08
/// // German:   08.02.2026
///
/// GeoDate(date: DateTime.now(), style: GeoDateStyle.long)
/// // American: February 8, 2026
/// // Japanese: 2026年02月08日
/// ```
class GeoDate extends StatelessWidget {
  /// Creates a culture-aware date display widget.
  const GeoDate({
    super.key,
    required this.date,
    this.style = GeoDateStyle.medium,
    this.customPattern,
    this.textStyle,
    this.includeTime = false,
  });

  /// The date to display.
  final DateTime date;

  /// The display style (short, medium, or long).
  final GeoDateStyle style;

  /// Optional custom date format pattern. Overrides [style] if provided.
  final String? customPattern;

  /// Optional text style for the displayed date.
  final TextStyle? textStyle;

  /// Whether to append the time after the date.
  final bool includeTime;

  @override
  Widget build(BuildContext context) {
    final profile = CultureScope.of(context);
    final formatted = _format(profile);
    return Text(formatted, style: textStyle);
  }

  String _format(CultureProfile profile) {
    final pattern = _resolvePattern(profile);
    var result = DateFormat(pattern, profile.effectiveLocale).format(date);

    if (includeTime) {
      final timeStr = DateFormat(
        profile.timeFormatPattern,
        profile.effectiveLocale,
      ).format(date);
      result = '$result $timeStr';
    }

    return result;
  }

  String _resolvePattern(CultureProfile profile) {
    if (customPattern != null) return customPattern!;
    switch (style) {
      case GeoDateStyle.short:
        return profile.shortDatePattern;
      case GeoDateStyle.medium:
        return profile.dateFormatPattern;
      case GeoDateStyle.long:
        return profile.longDatePattern;
    }
  }
}
