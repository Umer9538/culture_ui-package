/// Position of the primary action button in a button row.
enum PrimaryButtonPosition {
  /// Primary button on the left side.
  left,

  /// Primary button on the right side.
  right,
}

/// Text reading direction pattern.
enum ReadingPattern {
  /// Left-to-right (English, French, German, etc.).
  ltr,

  /// Right-to-left (Arabic, Hebrew, etc.).
  rtl,

  /// Top-to-bottom (traditional CJK).
  topToBottom,
}

/// UI density preference for layout spacing.
enum LayoutDensity {
  /// Tight spacing — common in Japanese/Chinese/Korean UIs.
  compact,

  /// Standard spacing — common in Western UIs.
  normal,

  /// Generous spacing — common in Arabic/Middle Eastern UIs.
  comfortable,
}

/// Semantic color meaning in a cultural context.
enum ColorSemantic {
  /// Danger or error.
  danger,

  /// Success or positive outcome.
  success,

  /// Warning or caution.
  warning,

  /// Informational.
  info,

  /// Luck or fortune.
  luck,

  /// Mourning or death.
  mourning,

  /// Celebration or festivity.
  celebration,

  /// Purity or cleanliness.
  purity,

  /// Love or romance.
  love,

  /// Wealth or prosperity.
  wealth,

  /// Authority or power.
  authority,
}

/// Form field layout preference.
enum FormLayoutPreference {
  /// Labels above inputs (Western default).
  labelAbove,

  /// Labels to the left of inputs.
  labelLeft,

  /// Labels as floating placeholders.
  floatingLabel,
}

/// Dialog button ordering preference.
enum DialogButtonOrder {
  /// Confirm on the right, cancel on the left (Windows/Android style).
  confirmRight,

  /// Confirm on the left, cancel on the right (macOS/iOS style).
  confirmLeft,
}

/// Text emphasis style cultural preference.
enum TextEmphasisStyle {
  /// Bold text for emphasis.
  bold,

  /// Dots above/below characters (Japanese/Chinese emphasis marks).
  emphasisDots,

  /// Underline for emphasis.
  underline,

  /// Larger font size for emphasis.
  enlargedSize,
}

/// Truncation direction for overflowing text.
enum TruncationDirection {
  /// Truncate from the end (most Western languages).
  end,

  /// Truncate from the start (some RTL contexts).
  start,

  /// Truncate from the middle.
  middle,
}

/// Position of the currency symbol relative to the amount.
enum CurrencySymbolPosition {
  /// Symbol before the amount (e.g., $100).
  before,

  /// Symbol after the amount (e.g., 100€).
  after,
}

/// Expected order of name components.
enum NameOrder {
  /// Given name first (e.g., John Smith).
  givenFirst,

  /// Family name first (e.g., Smith John / 田中太郎).
  familyFirst,
}
