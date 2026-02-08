import 'package:flutter/material.dart';

import '../core/culture_provider.dart';
import '../core/culture_profile.dart';
import '../core/enums.dart';

enum _GeoFieldType { custom, name, postalCode, phone }

/// A form field that adapts its validation patterns based on cultural context.
///
/// ```dart
/// GeoFormField.postalCode(controller: zipController)
/// // American: validates 5-digit (12345) or 5+4 (12345-6789)
/// // Japanese: validates 3-4 (123-4567)
/// // German:   validates 5-digit (12345)
///
/// GeoFormField.phone(controller: phoneController)
/// // Validates using culture-specific phone patterns
/// ```
class GeoFormField extends StatelessWidget {
  /// Creates a custom culture-aware form field.
  const GeoFormField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.validator,
    this.keyboardType,
    this.decoration,
  }) : _fieldType = _GeoFieldType.custom;

  /// Creates a name input field that adapts to cultural name order.
  const GeoFormField.name({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.decoration,
  }) : _fieldType = _GeoFieldType.name,
       validator = null,
       keyboardType = TextInputType.name;

  /// Creates a postal code field with culture-specific validation.
  const GeoFormField.postalCode({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.decoration,
  }) : _fieldType = _GeoFieldType.postalCode,
       validator = null,
       keyboardType = TextInputType.text;

  /// Creates a phone number field with culture-specific validation.
  const GeoFormField.phone({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.decoration,
  }) : _fieldType = _GeoFieldType.phone,
       validator = null,
       keyboardType = TextInputType.phone;

  /// Text editing controller.
  final TextEditingController controller;

  /// Optional label text. Falls back to a default based on field type.
  final String? label;

  /// Optional hint text.
  final String? hint;

  /// Custom validator. Overrides culture-based validation if provided.
  final String? Function(String?)? validator;

  /// Keyboard type.
  final TextInputType? keyboardType;

  /// Custom input decoration. Overrides default decoration if provided.
  final InputDecoration? decoration;

  final _GeoFieldType _fieldType;

  @override
  Widget build(BuildContext context) {
    final profile = CultureScope.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textDirection: profile.readingPattern == ReadingPattern.rtl
          ? TextDirection.rtl
          : TextDirection.ltr,
      decoration:
          decoration ??
          InputDecoration(
            labelText: label ?? _defaultLabel(profile),
            hintText: hint,
          ),
      validator: validator ?? _buildValidator(profile),
    );
  }

  String _defaultLabel(CultureProfile profile) {
    switch (_fieldType) {
      case _GeoFieldType.name:
        return profile.nameInputExpectsFamily == NameOrder.familyFirst
            ? 'Family Name'
            : 'Full Name';
      case _GeoFieldType.postalCode:
        return 'Postal Code';
      case _GeoFieldType.phone:
        return 'Phone Number';
      case _GeoFieldType.custom:
        return '';
    }
  }

  String? Function(String?)? _buildValidator(CultureProfile profile) {
    switch (_fieldType) {
      case _GeoFieldType.postalCode:
        final pattern = profile.postalCodePattern;
        if (pattern == null) return null;
        return (value) {
          if (value == null || value.isEmpty) return null;
          if (!RegExp(pattern).hasMatch(value)) {
            return 'Invalid postal code format';
          }
          return null;
        };
      case _GeoFieldType.phone:
        final pattern = profile.phoneNumberPattern;
        if (pattern == null) return null;
        return (value) {
          if (value == null || value.isEmpty) return null;
          if (!RegExp(pattern).hasMatch(value)) {
            return 'Invalid phone number format';
          }
          return null;
        };
      case _GeoFieldType.name:
      case _GeoFieldType.custom:
        return null;
    }
  }
}
