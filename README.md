# culture_ui

[![pub package](https://img.shields.io/pub/v/culture_ui.svg)](https://pub.dev/packages/culture_ui)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

**Semantic Geo-Context Widgets for Flutter** — automatically adapt UI *behavior* based on cultural context.

Flutter handles **translation** (text in different languages) and **formatting** (dates, numbers via `intl`). `culture_ui` handles **cultural UX behavior** — things like button placement order, dialog button ordering, layout density, color semantics, text emphasis styles, form validation patterns, and name ordering that vary across cultures.

> Instead of translating UI, we interpret it culturally.

---

## The Problem

Localization packages translate text. But UI *behavior* differs across cultures in ways that go beyond language:

- **Button placement**: Primary action on the right (US/Europe) vs. left (Arabic/RTL cultures)
- **Dialog ordering**: Confirm on right (Windows/Android) vs. left (macOS/French convention)
- **Layout density**: Spacious (Arabic UIs) vs. compact (Japanese/Korean/Chinese UIs)
- **Text emphasis**: Bold (Western) vs. emphasis dots (Japanese/Chinese)
- **Color meanings**: White = purity (Western) vs. mourning (Chinese/Indian)
- **Name ordering**: Given name first (Western) vs. family name first (Japanese/Korean/Chinese)
- **Form validation**: Postal codes, phone formats, and field labels vary per country

`culture_ui` provides a single `CultureScope` widget and a set of `Geo*` widgets that handle all of this automatically.

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  culture_ui: ^0.1.0
```

Then run:

```bash
flutter pub get
```

---

## Quick Start

### 1. Wrap your app with `CultureScope`

```dart
import 'package:culture_ui/culture_ui.dart';

void main() {
  runApp(
    CultureScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}
```

`CultureScope` automatically detects the device locale and resolves the appropriate culture profile. You can also provide an explicit profile:

```dart
CultureScope(
  profile: CultureProfiles.japanese,
  child: MaterialApp(...),
)
```

### 2. Use Geo* widgets anywhere in the tree

```dart
// Culture-aware date formatting
GeoDate(date: DateTime.now(), style: GeoDateStyle.long)
// American: "February 8, 2026"
// Japanese: "2026年02月08日"
// German:   "8. Februar 2026"

// Culture-aware number formatting
GeoNumber(value: 1234567.89)

// Culture-aware currency
GeoCurrency(amount: 99.99)
// American: "$99.99"
// Japanese: "¥100"
// German:   "99,99€"

// Text with cultural emphasis
GeoText('Important', emphasize: true)
// American: bold text
// Japanese: dotted underline

// Buttons with culture-aware ordering
GeoButtonPair(
  primary: GeoButtonConfig(label: 'Save', onPressed: _save),
  secondary: GeoButtonConfig(label: 'Cancel', onPressed: _cancel),
)
// American: [Cancel] [Save]  (primary on right)
// Arabic:   [Save] [Cancel]  (primary on left)
```

### 3. Access the profile directly

```dart
final culture = CultureScope.of(context);
// or with the extension:
final culture = context.culture;

if (culture.readingPattern == ReadingPattern.rtl) {
  // Handle RTL-specific logic
}
```

---

## Widget Reference

### Formatting Widgets

| Widget | Description | Key Properties |
|--------|-------------|----------------|
| `GeoDate` | Culture-aware date display | `date`, `style` (short/medium/long), `customPattern`, `includeTime` |
| `GeoNumber` | Culture-aware number display | `value`, `decimalDigits`, `compact` |
| `GeoCurrency` | Culture-aware currency display | `amount`, `currencyCodeOverride`, `symbolOverride` |
| `GeoText` | Text with cultural direction & emphasis | `data`, `emphasize`, `textStyle`, `maxLines`, `textAlign` |

### Layout & Interaction Widgets

| Widget | Description | Key Properties |
|--------|-------------|----------------|
| `GeoButtonPair` | Primary/secondary buttons with culture-aware ordering | `primary`, `secondary` (both `GeoButtonConfig`) |
| `GeoButton` | Single culture-aware button | `config`, `isPrimary` |
| `GeoDialog` | Dialog with culture-aware button ordering | `GeoDialog.show()` static method |
| `GeoLayoutDensity` | Density-appropriate padding wrapper | `child`, `densityOverride`, `customPadding` |
| `GeoFormField` | Form fields with culture-aware validation | `.name()`, `.postalCode()`, `.phone()` constructors |

### Semantic Widgets

| Widget | Description | Key Properties |
|--------|-------------|----------------|
| `GeoColor` | Semantic color resolution | `GeoColor.of(context, ColorSemantic.danger)` |
| `GeoIcon` | Culture-specific icon selection | `semanticKey`, `fallback`, `size`, `color` |
| `GeoImage` | Culture-specific image selection | `images` (map by culture ID), `fallback` |

### Utility

| Class | Description |
|-------|-------------|
| `GeoSpacing` | Access density-based spacing values via `GeoSpacing.of(context)` |
| `FormatUtils` | Static helpers: `formatDate()`, `formatNumber()`, `formatCurrency()`, `formatTime()` |

---

## Built-in Culture Profiles

`culture_ui` ships with **12 built-in profiles**, all defined as `const` for zero runtime allocation cost:

| Profile | Locales | Date Format | Button Position | Density | Dialog Order | Name Order |
|---------|---------|-------------|-----------------|---------|--------------|------------|
| `american` | en_US, en | MM/dd/yyyy | Right | Normal | Confirm-Right | Given first |
| `british` | en_GB | dd/MM/yyyy | Right | Normal | Confirm-Right | Given first |
| `arabic` | ar, ar_SA, ar_EG | dd/MM/yyyy | Left | Comfortable | Confirm-Left | Given first |
| `japanese` | ja, ja_JP | yyyy/MM/dd | Right | Compact | Confirm-Right | Family first |
| `german` | de, de_DE | dd.MM.yyyy | Right | Normal | Confirm-Right | Given first |
| `indian` | hi, en_IN | dd/MM/yyyy | Right | Normal | Confirm-Right | Given first |
| `chinese` | zh, zh_CN | yyyy/MM/dd | Right | Compact | Confirm-Right | Family first |
| `french` | fr, fr_FR | dd/MM/yyyy | Right | Normal | Confirm-Left | Given first |
| `korean` | ko, ko_KR | yyyy.MM.dd | Right | Compact | Confirm-Right | Family first |
| `brazilian` | pt_BR, pt | dd/MM/yyyy | Right | Normal | Confirm-Right | Given first |
| `spanish` | es, es_ES | dd/MM/yyyy | Right | Normal | Confirm-Right | Given first |
| `russian` | ru, ru_RU | dd.MM.yyyy | Right | Normal | Confirm-Right | Given first |

Access them via `CultureProfiles.japanese`, `CultureProfiles.arabic`, etc.

---

## Creating Custom Profiles

Create your own culture profile by instantiating `CultureProfile`:

```dart
const thai = CultureProfile(
  id: 'thai',
  locales: ['th', 'th_TH'],
  displayName: 'Thai',
  readingPattern: ReadingPattern.ltr,
  textEmphasisStyle: TextEmphasisStyle.bold,
  dateFormatPattern: 'dd/MM/yyyy',
  currencyCode: 'THB',
  currencySymbol: '฿',
  currencySymbolPosition: CurrencySymbolPosition.before,
  layoutDensity: LayoutDensity.normal,
  colorSemantics: {
    ColorSemantic.luck: Color(0xFFFFD700), // Gold
    ColorSemantic.mourning: Color(0xFF212121), // Black
  },
);
```

Register it for automatic locale detection:

```dart
CultureDetector.instance.registerProfile(thai);
```

Or modify an existing profile with `copyWith`:

```dart
final customAmerican = CultureProfiles.american.copyWith(
  layoutDensity: LayoutDensity.compact,
  textEmphasisStyle: TextEmphasisStyle.underline,
);
```

---

## Usage Examples

### Culture-Aware Dialogs

```dart
final confirmed = await GeoDialog.show(
  context: context,
  title: 'Delete Account',
  message: 'This action cannot be undone. Continue?',
  confirmLabel: 'Delete',
  cancelLabel: 'Keep',
);
// Button order adapts: [Keep] [Delete] (US) vs [Delete] [Keep] (French)
```

### Semantic Colors

```dart
Container(
  color: GeoColor.of(context, ColorSemantic.luck),
  // Red in Japanese/Chinese culture, Gold in Indian culture
)
```

### Culture-Aware Form Fields

```dart
Form(
  child: Column(
    children: [
      GeoFormField.name(controller: nameController),
      // Label: "Full Name" (US) vs "Family Name" (Japan)

      GeoFormField.postalCode(controller: postalController),
      // Validates: 12345 (US) vs 123-4567 (Japan) vs A1B 2C3 (UK)

      GeoFormField.phone(controller: phoneController),
    ],
  ),
)
```

### Layout Density

```dart
GeoLayoutDensity(
  child: MyContentWidget(),
)
// Padding: 8px (Japanese/compact) vs 16px (American/normal) vs 24px (Arabic/comfortable)
```

### Override Culture for a Subtree

```dart
CultureScope(
  profile: CultureProfiles.japanese,
  child: Column(
    children: [
      GeoDate(date: DateTime.now()), // Uses Japanese format
      GeoText('Preview', emphasize: true), // Uses emphasis dots
    ],
  ),
)
```

### Culture-Specific Icons and Images

```dart
// Icons that change per culture
GeoIcon(
  semanticKey: 'home',
  fallback: Icons.home,
)

// Images that change per culture
GeoImage(
  images: {
    'american': AssetImage('assets/hero_us.png'),
    'japanese': AssetImage('assets/hero_jp.png'),
  },
  fallback: AssetImage('assets/hero_default.png'),
)
```

---

## Architecture

`culture_ui` follows Flutter's own `Theme`/`ThemeData` pattern:

```
CultureScope (like Theme)
  └── Provides CultureProfile (like ThemeData) via InheritedWidget
       └── Geo* widgets read profile from context and adapt behavior
```

- **CultureProfile** — Immutable `@immutable` data class holding all cultural config
- **CultureScope** — `InheritedWidget` wrapper with `of(context)` and `maybeOf(context)`
- **CultureDetector** — Resolves device `Locale` to the best matching `CultureProfile`
- **ProfileRegistry** — Manages profile lookup with support for custom profiles
- **Geo\* widgets** — Read `CultureScope.of(context)` and render culture-appropriate UI

Only dependency: [`intl`](https://pub.dev/packages/intl) (for `DateFormat` and `NumberFormat`).

---

## CultureProfile Fields

The `CultureProfile` class contains configuration for:

| Category | Fields |
|----------|--------|
| **Identity** | `id`, `locales`, `displayName` |
| **Text** | `readingPattern`, `textEmphasisStyle`, `truncationDirection` |
| **Date/Time** | `dateFormatPattern`, `shortDatePattern`, `longDatePattern`, `timeFormatPattern`, `uses24HourTime` |
| **Numbers** | `numberLocale` |
| **Currency** | `currencyCode`, `currencySymbol`, `currencySymbolPosition`, `currencyDecimalDigits` |
| **Layout** | `primaryButtonPosition`, `dialogButtonOrder`, `layoutDensity`, `formLayoutPreference`, `defaultPadding`, `compactPadding`, `comfortablePadding` |
| **Semantics** | `colorSemantics` (Map\<ColorSemantic, Color\>), `iconOverrides` (Map\<String, IconData\>) |
| **Forms** | `nameInputExpectsFamily`, `postalCodePattern`, `phoneNumberPattern` |

---

## Enums

| Enum | Values |
|------|--------|
| `ReadingPattern` | `ltr`, `rtl`, `topToBottom` |
| `LayoutDensity` | `compact`, `normal`, `comfortable` |
| `TextEmphasisStyle` | `bold`, `emphasisDots`, `underline`, `enlargedSize` |
| `PrimaryButtonPosition` | `left`, `right` |
| `DialogButtonOrder` | `confirmRight`, `confirmLeft` |
| `ColorSemantic` | `danger`, `success`, `warning`, `info`, `luck`, `mourning`, `celebration`, `purity`, `love`, `wealth`, `authority` |
| `CurrencySymbolPosition` | `before`, `after` |
| `NameOrder` | `givenFirst`, `familyFirst` |
| `TruncationDirection` | `end`, `start`, `middle` |
| `FormLayoutPreference` | `labelAbove`, `labelLeft`, `floatingLabel` |

---

## Testing

The package includes **128 tests** covering all core classes, profiles, and widgets.

```bash
cd culture_ui
flutter test
```

Use the `wrapWithCulture()` test helper to wrap widgets with a specific profile in tests:

```dart
import 'package:culture_ui/culture_ui.dart';

Widget wrapWithCulture(Widget child, {required CultureProfile profile}) {
  return MaterialApp(
    home: CultureScope(profile: profile, child: Scaffold(body: child)),
  );
}

testWidgets('shows Japanese date format', (tester) async {
  await tester.pumpWidget(
    wrapWithCulture(
      GeoDate(date: DateTime(2026, 2, 8)),
      profile: CultureProfiles.japanese,
    ),
  );
  expect(find.text('2026/02/08'), findsOneWidget);
});
```

---

## Example App

A full example app is included in the `example/` directory with a culture-switcher dropdown and demos for all widgets.

```bash
cd example
flutter run
```

---

## Requirements

- Dart SDK: `^3.9.0`
- Flutter: `>=3.10.0`
- Dependencies: `intl ^0.19.0`

---

## License

MIT License. See [LICENSE](LICENSE) for details.

---

## Author

**Muhammad Umer**

- GitHub: [@Umer9538](https://github.com/Umer9538)
- Email: [muhammadumer9538@gmail.com](mailto:muhammadumer9538@gmail.com)
