import 'dart:ui' show Locale;

import 'culture_profile.dart';
import '../profiles/profile_registry.dart';

/// Resolves a [Locale] to a [CultureProfile].
///
/// The default [instance] uses the built-in [ProfileRegistry].
/// Create a custom instance with your own registry for custom behavior.
///
/// Resolution order:
/// 1. Exact match: `language_country` (e.g., 'en_US')
/// 2. Language match: `language` only (e.g., 'en')
/// 3. Fallback: [ProfileRegistry.defaultProfile]
///
/// ```dart
/// final profile = CultureDetector.instance.resolve(Locale('ja', 'JP'));
/// // Returns CultureProfiles.japanese
/// ```
class CultureDetector {
  /// Creates a detector with an optional custom [ProfileRegistry].
  CultureDetector({ProfileRegistry? registry})
    : _registry = registry ?? ProfileRegistry.instance;

  /// The shared singleton instance using the default [ProfileRegistry].
  static final CultureDetector instance = CultureDetector();

  final ProfileRegistry _registry;

  /// Resolves a [Locale] to the best matching [CultureProfile].
  CultureProfile resolve(Locale locale) {
    // Try full locale (language_country)
    if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
      final fullLocale = '${locale.languageCode}_${locale.countryCode}';
      final result = _registry.lookup(fullLocale);
      if (result != null) return result;
    }

    // Try language only
    final result = _registry.lookup(locale.languageCode);
    if (result != null) return result;

    // Fallback to default
    return _registry.defaultProfile;
  }

  /// Register an additional profile with the underlying registry.
  void registerProfile(CultureProfile profile) {
    _registry.register(profile);
  }

  /// Remove a profile from the underlying registry.
  void unregisterProfile(String profileId) {
    _registry.unregister(profileId);
  }
}
