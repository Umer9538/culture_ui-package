import 'package:flutter/widgets.dart';

import '../core/culture_profile.dart';
import '../core/culture_provider.dart';
import '../core/enums.dart';

/// Wraps a child with padding that adapts to the cultural layout density.
///
/// ```dart
/// GeoLayoutDensity(child: Card(child: content))
/// // Japanese: compact padding (8px)
/// // American: normal padding (16px)
/// // Arabic:   comfortable padding (24px)
/// ```
class GeoLayoutDensity extends StatelessWidget {
  /// Creates a density-aware padding wrapper.
  const GeoLayoutDensity({
    super.key,
    required this.child,
    this.densityOverride,
    this.customPadding,
  });

  /// The child widget to wrap with density-aware padding.
  final Widget child;

  /// Override the culture's default density.
  final LayoutDensity? densityOverride;

  /// Custom padding values per density level. Falls back to profile defaults.
  final Map<LayoutDensity, EdgeInsets>? customPadding;

  @override
  Widget build(BuildContext context) {
    final profile = CultureScope.of(context);
    final density = densityOverride ?? profile.layoutDensity;

    EdgeInsets padding;
    if (customPadding != null && customPadding!.containsKey(density)) {
      padding = customPadding![density]!;
    } else {
      switch (density) {
        case LayoutDensity.compact:
          padding = profile.compactPadding;
        case LayoutDensity.normal:
          padding = profile.defaultPadding;
        case LayoutDensity.comfortable:
          padding = profile.comfortablePadding;
      }
    }

    return Padding(padding: padding, child: child);
  }
}

/// Provides density-aware spacing values without wrapping in a Padding widget.
///
/// ```dart
/// final spacing = GeoSpacing.of(context);
/// SizedBox(height: spacing.vertical);
/// SizedBox(width: spacing.horizontal);
/// ```
class GeoSpacing {
  GeoSpacing._(this._profile);

  final CultureProfile _profile;

  /// Creates a [GeoSpacing] from the nearest [CultureScope].
  static GeoSpacing of(BuildContext context) {
    return GeoSpacing._(CultureScope.of(context));
  }

  /// Horizontal spacing value based on culture density.
  double get horizontal => _profile.densityPadding.left;

  /// Vertical spacing value based on culture density.
  double get vertical => _profile.densityPadding.top;

  /// Full padding based on culture density.
  EdgeInsets get padding => _profile.densityPadding;
}
