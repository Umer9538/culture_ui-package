import 'package:flutter/widgets.dart';

import '../core/culture_provider.dart';

/// Selects and displays an image appropriate for the current culture.
///
/// Provide a map of culture profile IDs to image providers, and a fallback.
/// The widget will display the image matching the current culture, or the
/// fallback if no match exists.
///
/// ```dart
/// GeoImage(
///   images: {
///     'american': AssetImage('assets/hero_us.png'),
///     'japanese': AssetImage('assets/hero_jp.png'),
///     'arabic': AssetImage('assets/hero_ar.png'),
///   },
///   fallback: AssetImage('assets/hero_default.png'),
///   width: 300,
///   height: 200,
/// )
/// ```
class GeoImage extends StatelessWidget {
  /// Creates a culture-aware image widget.
  const GeoImage({
    super.key,
    required this.images,
    required this.fallback,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.semanticLabel,
  });

  /// Map of culture profile IDs to image providers.
  final Map<String, ImageProvider> images;

  /// The fallback image if no culture-specific image is found.
  final ImageProvider fallback;

  /// Image width.
  final double? width;

  /// Image height.
  final double? height;

  /// How the image should be inscribed into the space.
  final BoxFit fit;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final profile = CultureScope.of(context);
    final imageProvider = images[profile.id] ?? fallback;
    return Image(
      image: imageProvider,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
    );
  }
}
