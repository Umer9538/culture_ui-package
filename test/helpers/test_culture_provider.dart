import 'package:flutter/material.dart';
import 'package:culture_ui/culture_ui.dart';

/// Wraps a widget with [CultureScope] and [MaterialApp] for testing.
Widget wrapWithCulture(Widget child, {CultureProfile? profile}) {
  return MaterialApp(
    home: CultureScope(
      profile: profile ?? CultureProfiles.american,
      child: Scaffold(body: child),
    ),
  );
}
