import 'package:flutter/widgets.dart';

import '../core/culture_provider.dart';

/// An icon widget that adapts to cultural icon preferences.
///
/// Different cultures may associate different icons with the same concept.
/// Provide a `semanticKey` string and a `fallback` icon. If the current
/// culture profile has an override for that key, it will be used.
///
/// ```dart
/// GeoIcon(semanticKey: 'mail', fallback: Icons.mail)
/// // Uses profile's iconOverrides['mail'] if defined, else Icons.mail
/// ```
class GeoIcon extends StatelessWidget {
  /// Creates a culture-aware icon widget.
  const GeoIcon({
    super.key,
    required this.semanticKey,
    required this.fallback,
    this.size,
    this.color,
    this.semanticLabel,
  });

  /// The semantic key to look up in the culture profile's icon overrides.
  final String semanticKey;

  /// The default icon to use if no override exists for [semanticKey].
  final IconData fallback;

  /// Icon size.
  final double? size;

  /// Icon color.
  final Color? color;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final profile = CultureScope.of(context);
    final iconData = profile.iconOverrides[semanticKey] ?? fallback;
    return Icon(
      iconData,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
    );
  }
}
