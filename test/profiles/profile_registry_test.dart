import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

void main() {
  group('ProfileRegistry', () {
    test('instance has all built-in profiles registered', () {
      final registry = ProfileRegistry.instance;

      expect(registry.lookup('en_US'), CultureProfiles.american);
      expect(registry.lookup('en'), CultureProfiles.american);
      expect(registry.lookup('en_GB'), CultureProfiles.british);
      expect(registry.lookup('ar'), CultureProfiles.arabic);
      expect(registry.lookup('ar_SA'), CultureProfiles.arabic);
      expect(registry.lookup('ja'), CultureProfiles.japanese);
      expect(registry.lookup('de'), CultureProfiles.german);
      expect(registry.lookup('hi'), CultureProfiles.indian);
      expect(registry.lookup('zh'), CultureProfiles.chinese);
      expect(registry.lookup('fr'), CultureProfiles.french);
      expect(registry.lookup('ko'), CultureProfiles.korean);
      expect(registry.lookup('pt_BR'), CultureProfiles.brazilian);
      expect(registry.lookup('es'), CultureProfiles.spanish);
      expect(registry.lookup('ru'), CultureProfiles.russian);
    });

    test('lookup returns null for unknown locale', () {
      final registry = ProfileRegistry.instance;
      expect(registry.lookup('xx_XX'), isNull);
    });

    test('defaultProfile is american', () {
      expect(ProfileRegistry.instance.defaultProfile, CultureProfiles.american);
    });

    test('register adds a custom profile', () {
      final registry = ProfileRegistry.instance;
      const customProfile = CultureProfile(
        id: 'thai',
        locales: ['th', 'th_TH'],
        displayName: 'Thai',
      );

      registry.register(customProfile);

      expect(registry.lookup('th'), customProfile);
      expect(registry.lookup('th_TH'), customProfile);

      // Clean up
      registry.unregister('thai');
    });

    test('unregister removes a custom profile', () {
      final registry = ProfileRegistry.instance;
      const customProfile = CultureProfile(
        id: 'custom_test',
        locales: ['xx'],
        displayName: 'Custom',
      );

      registry.register(customProfile);
      expect(registry.lookup('xx'), customProfile);

      registry.unregister('custom_test');
      expect(registry.lookup('xx'), isNull);
    });

    test('allProfiles returns unique profiles', () {
      final profiles = ProfileRegistry.instance.allProfiles;
      final ids = profiles.map((p) => p.id).toSet();
      // Each profile should appear only once even if it has multiple locale keys
      expect(ids.length, profiles.length);
    });
  });
}
