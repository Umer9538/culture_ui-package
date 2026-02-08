import 'package:flutter/material.dart';
import 'package:culture_ui/culture_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.selectedProfile,
    required this.onProfileChanged,
  });

  final CultureProfile selectedProfile;
  final ValueChanged<CultureProfile> onProfileChanged;

  @override
  Widget build(BuildContext context) {
    final culture = context.culture;
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('culture_ui Demo'),
      ),
      body: SingleChildScrollView(
        child: GeoLayoutDensity(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Culture Selector
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Culture',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButton<CultureProfile>(
                        value: selectedProfile,
                        isExpanded: true,
                        items: CultureProfiles.all
                            .map((p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(
                                      '${p.displayName} (${p.locales.first})'),
                                ))
                            .toList(),
                        onChanged: (p) {
                          if (p != null) onProfileChanged(p);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Date Formatting
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GeoDate',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Short: '),
                          GeoDate(date: now, style: GeoDateStyle.short),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Medium: '),
                          GeoDate(date: now, style: GeoDateStyle.medium),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Long: '),
                          GeoDate(date: now, style: GeoDateStyle.long),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('With time: '),
                          GeoDate(date: now, includeTime: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Number & Currency
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GeoNumber & GeoCurrency',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('1,234,567.89: '),
                          const GeoNumber(value: 1234567.89),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Compact 1.5M: '),
                          const GeoNumber(value: 1500000, compact: true),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Currency: '),
                          const GeoCurrency(amount: 1234.50),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Text
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GeoText',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      const GeoText('Normal text'),
                      const GeoText('Emphasized text', emphasize: true),
                      const GeoText(
                        'Truncated long text that should be cut off after one line to demonstrate cultural truncation',
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Buttons
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GeoButtonPair',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Primary position: ${culture.primaryButtonPosition.name}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      GeoButtonPair(
                        primary:
                            GeoButtonConfig(label: 'Save', onPressed: () {}),
                        secondary:
                            GeoButtonConfig(label: 'Cancel', onPressed: () {}),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Dialog
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GeoDialog',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Button order: ${culture.dialogButtonOrder.name}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          GeoDialog.show(
                            context: context,
                            title: 'Confirm Action',
                            contentText:
                                'Notice how button order changes per culture.',
                            confirmLabel: 'Confirm',
                            cancelLabel: 'Cancel',
                          );
                        },
                        child: const Text('Show Dialog'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Color Semantics
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GeoColor (Semantic Colors)',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: culture.colorSemantics.entries.map((entry) {
                          return Chip(
                            avatar: CircleAvatar(
                              backgroundColor: entry.value,
                            ),
                            label: Text(entry.key.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Profile Info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile Info',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text('ID: ${culture.id}'),
                      Text('Density: ${culture.layoutDensity.name}'),
                      Text('Reading: ${culture.readingPattern.name}'),
                      Text('Name order: ${culture.nameInputExpectsFamily.name}'),
                      Text('24h time: ${culture.uses24HourTime}'),
                      Text(
                          'Currency: ${culture.currencySymbol} (${culture.currencyCode})'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
