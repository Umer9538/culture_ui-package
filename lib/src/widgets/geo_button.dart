import 'package:flutter/material.dart';

import '../core/culture_provider.dart';
import '../core/enums.dart';

/// Configuration for a button in a [GeoButtonPair].
class GeoButtonConfig {
  /// Creates a button configuration.
  const GeoButtonConfig({required this.label, this.onPressed, this.icon});

  /// The button label text.
  final String label;

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  /// Optional leading icon.
  final IconData? icon;
}

/// A pair of primary/secondary buttons with culturally correct placement.
///
/// In Western cultures, the primary button is typically on the right.
/// In RTL cultures like Arabic, the primary button appears on the left.
///
/// ```dart
/// GeoButtonPair(
///   primary: GeoButtonConfig(label: 'Save', onPressed: save),
///   secondary: GeoButtonConfig(label: 'Cancel', onPressed: cancel),
/// )
/// // American: [Cancel] [Save]   (primary right)
/// // Arabic:   [Save] [Cancel]   (primary left)
/// ```
class GeoButtonPair extends StatelessWidget {
  /// Creates a culturally-aware button pair.
  const GeoButtonPair({
    super.key,
    required this.primary,
    required this.secondary,
    this.spacing = 8.0,
    this.mainAxisSize = MainAxisSize.min,
  });

  /// The primary (main action) button config.
  final GeoButtonConfig primary;

  /// The secondary (cancel/dismiss) button config.
  final GeoButtonConfig secondary;

  /// Spacing between the two buttons.
  final double spacing;

  /// How much horizontal space the button row should occupy.
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final profile = CultureScope.of(context);

    final primaryWidget = ElevatedButton.icon(
      onPressed: primary.onPressed,
      icon: primary.icon != null ? Icon(primary.icon) : const SizedBox.shrink(),
      label: Text(primary.label),
    );
    final secondaryWidget = TextButton.icon(
      onPressed: secondary.onPressed,
      icon: secondary.icon != null
          ? Icon(secondary.icon)
          : const SizedBox.shrink(),
      label: Text(secondary.label),
    );

    final List<Widget> buttons;
    if (profile.primaryButtonPosition == PrimaryButtonPosition.right) {
      buttons = [secondaryWidget, SizedBox(width: spacing), primaryWidget];
    } else {
      buttons = [primaryWidget, SizedBox(width: spacing), secondaryWidget];
    }

    return Row(mainAxisSize: mainAxisSize, children: buttons);
  }
}

/// A single button that follows cultural conventions.
///
/// ```dart
/// GeoButton(label: 'Continue', onPressed: next)
/// ```
class GeoButton extends StatelessWidget {
  /// Creates a culture-aware button.
  const GeoButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.style,
  });

  /// The button label.
  final String label;

  /// Callback when pressed.
  final VoidCallback? onPressed;

  /// Whether this is a primary (elevated) or secondary (text) button.
  final bool isPrimary;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional button style override.
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      if (icon != null) {
        return ElevatedButton.icon(
          onPressed: onPressed,
          style: style,
          icon: Icon(icon),
          label: Text(label),
        );
      }
      return ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(label),
      );
    }

    if (icon != null) {
      return TextButton.icon(
        onPressed: onPressed,
        style: style,
        icon: Icon(icon),
        label: Text(label),
      );
    }
    return TextButton(onPressed: onPressed, style: style, child: Text(label));
  }
}
