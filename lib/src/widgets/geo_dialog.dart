import 'package:flutter/material.dart';

import '../core/culture_provider.dart';
import '../core/enums.dart';

/// Shows a dialog with culturally appropriate button ordering.
///
/// ```dart
/// GeoDialog.show(
///   context: context,
///   title: 'Confirm',
///   contentText: 'Are you sure?',
///   confirmLabel: 'Yes',
///   cancelLabel: 'No',
///   onConfirm: () => doSomething(),
/// );
/// ```
///
/// In American culture, confirm is on the right: `[No] [Yes]`
/// In French/Arabic culture, confirm may be on the left: `[Yes] [No]`
class GeoDialog {
  GeoDialog._();

  /// Shows a culturally-aware dialog.
  ///
  /// Returns `true` if confirmed, `false` if cancelled, or `null` if dismissed.
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    Widget? content,
    String? contentText,
    String confirmLabel = 'OK',
    String? cancelLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    final profile = CultureScope.of(context);

    final confirmButton = TextButton(
      onPressed: () {
        onConfirm?.call();
        Navigator.of(context).pop(true);
      },
      child: Text(confirmLabel),
    );

    final cancelButton = cancelLabel != null
        ? TextButton(
            onPressed: () {
              onCancel?.call();
              Navigator.of(context).pop(false);
            },
            child: Text(cancelLabel),
          )
        : null;

    List<Widget> actions;
    if (cancelButton == null) {
      actions = [confirmButton];
    } else if (profile.dialogButtonOrder == DialogButtonOrder.confirmRight) {
      actions = [cancelButton, confirmButton];
    } else {
      actions = [confirmButton, cancelButton];
    }

    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: content ?? (contentText != null ? Text(contentText) : null),
        actions: actions,
      ),
    );
  }
}
