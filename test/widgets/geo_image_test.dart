import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

/// A minimal 1x1 transparent PNG as bytes.
final _transparentPng = Uint8List.fromList([
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x62,
  0x00,
  0x00,
  0x00,
  0x02,
  0x00,
  0x01,
  0xE5,
  0x27,
  0xDE,
  0xFC,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

void main() {
  group('GeoImage', () {
    testWidgets('selects culture-specific image based on profile id', (
      tester,
    ) async {
      final usImage = MemoryImage(_transparentPng);
      final jpImage = MemoryImage(Uint8List.fromList([..._transparentPng]));
      final defaultImage = MemoryImage(
        Uint8List.fromList([..._transparentPng]),
      );

      await tester.pumpWidget(
        wrapWithCulture(
          GeoImage(
            images: {'american': usImage, 'japanese': jpImage},
            fallback: defaultImage,
          ),
          profile: CultureProfiles.japanese,
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, jpImage);
    });

    testWidgets('uses fallback when no culture match', (tester) async {
      final usImage = MemoryImage(_transparentPng);
      final defaultImage = MemoryImage(
        Uint8List.fromList([..._transparentPng]),
      );

      await tester.pumpWidget(
        wrapWithCulture(
          GeoImage(images: {'american': usImage}, fallback: defaultImage),
          profile: CultureProfiles.korean,
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, defaultImage);
    });

    testWidgets('applies width, height, and fit', (tester) async {
      final defaultImage = MemoryImage(_transparentPng);

      await tester.pumpWidget(
        wrapWithCulture(
          GeoImage(
            images: const {},
            fallback: defaultImage,
            width: 300,
            height: 200,
            fit: BoxFit.cover,
          ),
          profile: CultureProfiles.american,
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.width, 300);
      expect(image.height, 200);
      expect(image.fit, BoxFit.cover);
    });
  });
}
