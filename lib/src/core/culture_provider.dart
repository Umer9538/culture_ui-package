import 'package:flutter/widgets.dart';

import 'culture_detector.dart';
import 'culture_profile.dart';

/// Provides a [CultureProfile] to all descendant widgets.
///
/// Similar to [Theme], place this near the top of the widget tree.
/// Descendant widgets access the culture profile using
/// [CultureScope.of(context)] or the `context.culture` extension.
///
/// **Auto-detect from device locale:**
/// ```dart
/// CultureScope(
///   child: MaterialApp(...),
/// )
/// ```
///
/// **Override with explicit profile:**
/// ```dart
/// CultureScope(
///   profile: CultureProfiles.japanese,
///   child: MaterialApp(...),
/// )
/// ```
///
/// **Override for a subtree (like nested Theme):**
/// ```dart
/// CultureScope(
///   profile: CultureProfiles.arabic,
///   child: MyArabicSection(),
/// )
/// ```
class CultureScope extends StatelessWidget {
  /// Creates a culture scope.
  ///
  /// If [profile] is provided, it is used directly.
  /// If [locale] is provided (without [profile]), it is resolved to a profile.
  /// Otherwise, the device locale is auto-detected.
  const CultureScope({
    super.key,
    this.profile,
    this.locale,
    this.detector,
    required this.child,
  });

  /// Explicit [CultureProfile] to use. If null, auto-detects from locale.
  final CultureProfile? profile;

  /// Explicit locale to resolve. If null, uses device locale.
  final Locale? locale;

  /// Custom detector for resolving locales to profiles.
  /// If null, uses [CultureDetector.instance].
  final CultureDetector? detector;

  /// The widget below this in the tree.
  final Widget child;

  /// Retrieves the [CultureProfile] from the nearest ancestor [CultureScope].
  ///
  /// Throws if no [CultureScope] is found. Use [maybeOf] for nullable access.
  static CultureProfile of(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<_InheritedCulture>();
    assert(
      inherited != null,
      'No CultureScope found in the widget tree. '
      'Wrap your app with CultureScope.',
    );
    return inherited!.profile;
  }

  /// Retrieves the [CultureProfile] from the nearest ancestor [CultureScope],
  /// or null if none exists.
  static CultureProfile? maybeOf(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<_InheritedCulture>();
    return inherited?.profile;
  }

  @override
  Widget build(BuildContext context) {
    final resolvedProfile =
        profile ??
        (detector ?? CultureDetector.instance).resolve(
          locale ?? _getDeviceLocale(),
        );
    return _InheritedCulture(profile: resolvedProfile, child: child);
  }

  Locale _getDeviceLocale() {
    return WidgetsBinding.instance.platformDispatcher.locale;
  }
}

class _InheritedCulture extends InheritedWidget {
  const _InheritedCulture({required this.profile, required super.child});

  final CultureProfile profile;

  @override
  bool updateShouldNotify(_InheritedCulture old) => profile != old.profile;
}
