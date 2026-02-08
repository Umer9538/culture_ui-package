import 'package:flutter/material.dart';
import 'package:culture_ui/culture_ui.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const CultureUiExample());
}

class CultureUiExample extends StatefulWidget {
  const CultureUiExample({super.key});

  @override
  State<CultureUiExample> createState() => _CultureUiExampleState();
}

class _CultureUiExampleState extends State<CultureUiExample> {
  CultureProfile _selectedProfile = CultureProfiles.american;

  @override
  Widget build(BuildContext context) {
    return CultureScope(
      profile: _selectedProfile,
      child: MaterialApp(
        title: 'culture_ui Example',
        theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
        home: HomePage(
          selectedProfile: _selectedProfile,
          onProfileChanged: (profile) {
            setState(() => _selectedProfile = profile);
          },
        ),
      ),
    );
  }
}
