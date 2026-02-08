import '../core/culture_profile.dart';
import 'profiles.dart';

/// Central registry that maps locale strings to [CultureProfile] instances.
///
/// Uses a singleton with a mutable map so developers can register
/// custom profiles at runtime.
///
/// ```dart
/// // Register a custom profile
/// ProfileRegistry.instance.register(myThaiProfile);
///
/// // Look up a profile by locale key
/// final profile = ProfileRegistry.instance.lookup('th');
/// ```
class ProfileRegistry {
  ProfileRegistry._() {
    _registerBuiltInProfiles();
  }

  /// The shared singleton instance with all built-in profiles pre-registered.
  static final ProfileRegistry instance = ProfileRegistry._();

  final Map<String, CultureProfile> _profiles = {};

  /// The default profile used when no matching profile is found.
  CultureProfile get defaultProfile => CultureProfiles.american;

  /// Look up a profile by locale string (e.g., 'en_US', 'ja', 'ar').
  ///
  /// Returns `null` if no profile is registered for the given key.
  CultureProfile? lookup(String localeKey) => _profiles[localeKey];

  /// Register a profile. Each locale in [profile.locales] becomes a lookup key.
  void register(CultureProfile profile) {
    for (final locale in profile.locales) {
      _profiles[locale] = profile;
    }
  }

  /// Remove all locale mappings for a given profile ID.
  void unregister(String profileId) {
    _profiles.removeWhere((_, profile) => profile.id == profileId);
  }

  /// Returns all registered profiles (may contain duplicates for
  /// profiles with multiple locale keys).
  List<CultureProfile> get allProfiles => _profiles.values.toSet().toList();

  void _registerBuiltInProfiles() {
    for (final profile in CultureProfiles.all) {
      register(profile);
    }
  }
}
