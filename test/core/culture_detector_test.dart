import 'dart:ui' show Locale;

import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

void main() {
  group('CultureDetector', () {
    late CultureDetector detector;

    setUp(() {
      detector = CultureDetector.instance;
    });

    test('resolves exact locale match (language_country)', () {
      final profile = detector.resolve(const Locale('en', 'GB'));
      expect(profile, CultureProfiles.british);
    });

    test('resolves language-only match', () {
      final profile = detector.resolve(const Locale('ja'));
      expect(profile, CultureProfiles.japanese);
    });

    test('resolves language when country does not match', () {
      // 'ar_QA' is not registered, but 'ar' is
      final profile = detector.resolve(const Locale('ar', 'QA'));
      expect(profile, CultureProfiles.arabic);
    });

    test('falls back to default for unknown locale', () {
      final profile = detector.resolve(const Locale('xx', 'XX'));
      expect(profile, CultureProfiles.american);
    });

    test('resolves en_US correctly', () {
      final profile = detector.resolve(const Locale('en', 'US'));
      expect(profile, CultureProfiles.american);
    });

    test('resolves de_DE correctly', () {
      final profile = detector.resolve(const Locale('de', 'DE'));
      expect(profile, CultureProfiles.german);
    });

    test('resolves zh_CN correctly', () {
      final profile = detector.resolve(const Locale('zh', 'CN'));
      expect(profile, CultureProfiles.chinese);
    });

    test('resolves pt_BR correctly', () {
      final profile = detector.resolve(const Locale('pt', 'BR'));
      expect(profile, CultureProfiles.brazilian);
    });

    test('registerProfile makes new profile resolvable', () {
      const customProfile = CultureProfile(
        id: 'detector_test_custom',
        locales: ['sv', 'sv_SE'],
        displayName: 'Swedish',
      );

      detector.registerProfile(customProfile);

      expect(detector.resolve(const Locale('sv')), customProfile);
      expect(detector.resolve(const Locale('sv', 'SE')), customProfile);

      // Clean up
      detector.unregisterProfile('detector_test_custom');
    });
  });
}
