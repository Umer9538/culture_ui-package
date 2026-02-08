import 'package:flutter/material.dart';

import '../core/culture_provider.dart';
import '../core/enums.dart';

/// Provides culturally-aware color resolution based on semantic meaning.
///
/// Different cultures associate different colors with the same concept.
/// For example, red means "danger" in Western cultures but "luck" in Chinese.
///
/// ```dart
/// Container(color: GeoColor.of(context, ColorSemantic.danger))
/// // American: red
/// // Any culture: their version of "danger" color
///
/// Container(color: GeoColor.of(context, ColorSemantic.luck))
/// // Chinese: red
/// // American: not defined → returns fallback
/// ```
class GeoColor {
  GeoColor._();

  /// Returns the color for a semantic meaning in the current culture.
  ///
  /// Returns [fallback] if the semantic is not defined for the current culture.
  /// If [fallback] is null, returns [Colors.grey].
  static Color of(
    BuildContext context,
    ColorSemantic semantic, {
    Color? fallback,
  }) {
    final profile = CultureScope.of(context);
    return profile.colorSemantics[semantic] ?? fallback ?? Colors.grey;
  }

  /// Returns the color or null if the semantic is not defined.
  static Color? maybeOf(BuildContext context, ColorSemantic semantic) {
    final profile = CultureScope.maybeOf(context);
    return profile?.colorSemantics[semantic];
  }

  /// Returns all semantic colors for the current culture.
  static Map<ColorSemantic, Color> allOf(BuildContext context) {
    return CultureScope.of(context).colorSemantics;
  }
}
