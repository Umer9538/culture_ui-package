import 'package:flutter/widgets.dart';

import 'culture_profile.dart';
import 'culture_provider.dart';

/// Convenience extensions on [BuildContext] for accessing the culture profile.
///
/// ```dart
/// final culture = context.culture;
/// final dateFormat = culture.dateFormatPattern;
/// ```
extension CultureBuildContext on BuildContext {
  /// Shorthand for [CultureScope.of(context)].
  ///
  /// Throws if no [CultureScope] exists in the widget tree.
  CultureProfile get culture => CultureScope.of(this);

  /// Shorthand for [CultureScope.maybeOf(context)].
  ///
  /// Returns null if no [CultureScope] exists in the widget tree.
  CultureProfile? get maybeCulture => CultureScope.maybeOf(this);
}
