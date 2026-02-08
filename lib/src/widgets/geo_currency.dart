import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../core/culture_provider.dart';

/// Formats a monetary value with the culturally appropriate currency
/// symbol, position, and number format.
///
/// ```dart
/// GeoCurrency(amount: 1234.50)
/// // American: $1,234.50
/// // German:   1.234,50 €
/// // Japanese: ¥1,235
/// ```
class GeoCurrency extends StatelessWidget {
  /// Creates a culture-aware currency display widget.
  const GeoCurrency({
    super.key,
    required this.amount,
    this.currencyCodeOverride,
    this.symbolOverride,
    this.textStyle,
  });

  /// The monetary amount to display.
  final num amount;

  /// Optional currency code override (e.g., 'EUR'). Uses profile default if null.
  final String? currencyCodeOverride;

  /// Optional currency symbol override (e.g., '€'). Uses profile default if null.
  final String? symbolOverride;

  /// Optional text style for the displayed currency.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final profile = CultureScope.of(context);
    final formatted = NumberFormat.currency(
      locale: profile.effectiveLocale,
      name: currencyCodeOverride ?? profile.currencyCode,
      symbol: symbolOverride ?? profile.currencySymbol,
      decimalDigits: profile.currencyDecimalDigits,
    ).format(amount);

    return Text(formatted, style: textStyle);
  }
}
