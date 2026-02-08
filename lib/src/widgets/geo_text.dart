import 'package:flutter/widgets.dart';

import '../core/culture_profile.dart';
import '../core/culture_provider.dart';
import '../core/enums.dart';

/// A text widget that adapts its behavior based on cultural context.
///
/// Unlike plain [Text], GeoText handles:
/// - Correct text direction (LTR/RTL) based on culture
/// - Culturally appropriate emphasis styling (bold, dots, underline, etc.)
/// - Truncation direction
///
/// ```dart
/// GeoText('Welcome')
/// // Renders LTR for English, RTL for Arabic
///
/// GeoText('Important', emphasize: true)
/// // American: bold text
/// // Japanese: text with emphasis dots
/// ```
class GeoText extends StatelessWidget {
  /// Creates a culture-aware text widget.
  const GeoText(
    this.data, {
    super.key,
    this.emphasize = false,
    this.textStyle,
    this.maxLines,
    this.textAlign,
    this.semanticsLabel,
  });

  /// The text to display.
  final String data;

  /// Whether to apply culturally appropriate emphasis styling.
  final bool emphasize;

  /// Optional base text style.
  final TextStyle? textStyle;

  /// Maximum number of lines before truncation.
  final int? maxLines;

  /// Text alignment.
  final TextAlign? textAlign;

  /// Semantics label for accessibility.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final profile = CultureScope.of(context);

    TextStyle effectiveStyle = textStyle ?? DefaultTextStyle.of(context).style;

    if (emphasize) {
      effectiveStyle = _applyEmphasis(effectiveStyle, profile);
    }

    return Text(
      data,
      style: effectiveStyle,
      maxLines: maxLines,
      overflow: maxLines != null ? _resolveOverflow(profile) : null,
      textDirection: _resolveDirection(profile),
      textAlign: textAlign,
      semanticsLabel: semanticsLabel,
    );
  }

  TextStyle _applyEmphasis(TextStyle base, CultureProfile profile) {
    switch (profile.textEmphasisStyle) {
      case TextEmphasisStyle.bold:
        return base.copyWith(fontWeight: FontWeight.bold);
      case TextEmphasisStyle.underline:
        return base.copyWith(decoration: TextDecoration.underline);
      case TextEmphasisStyle.enlargedSize:
        return base.copyWith(fontSize: (base.fontSize ?? 14) * 1.2);
      case TextEmphasisStyle.emphasisDots:
        return base.copyWith(
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dotted,
        );
    }
  }

  TextOverflow _resolveOverflow(CultureProfile profile) {
    switch (profile.truncationDirection) {
      case TruncationDirection.end:
      case TruncationDirection.start:
      case TruncationDirection.middle:
        return TextOverflow.ellipsis;
    }
  }

  TextDirection _resolveDirection(CultureProfile profile) {
    switch (profile.readingPattern) {
      case ReadingPattern.rtl:
        return TextDirection.rtl;
      case ReadingPattern.ltr:
      case ReadingPattern.topToBottom:
        return TextDirection.ltr;
    }
  }
}
