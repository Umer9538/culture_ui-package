import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:culture_ui/culture_ui.dart';

import '../helpers/test_culture_provider.dart';

void main() {
  group('GeoIcon', () {
    testWidgets('uses fallback when no override exists', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoIcon(semanticKey: 'mail', fallback: Icons.mail),
          profile: CultureProfiles.american,
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.icon, Icons.mail);
    });

    testWidgets('uses override when defined in profile', (tester) async {
      final profile = CultureProfiles.american.copyWith(
        iconOverrides: {'mail': Icons.inbox},
      );

      await tester.pumpWidget(
        wrapWithCulture(
          const GeoIcon(semanticKey: 'mail', fallback: Icons.mail),
          profile: profile,
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.icon, Icons.inbox);
    });

    testWidgets('applies size', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoIcon(semanticKey: 'home', fallback: Icons.home, size: 48),
          profile: CultureProfiles.american,
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, 48);
    });

    testWidgets('applies color', (tester) async {
      await tester.pumpWidget(
        wrapWithCulture(
          const GeoIcon(
            semanticKey: 'home',
            fallback: Icons.home,
            color: Colors.red,
          ),
          profile: CultureProfiles.american,
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, Colors.red);
    });
  });
}
