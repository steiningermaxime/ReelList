import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'fr';
  String _selectedTheme = 'system';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Apparence'),
          
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Langue'),
            subtitle: Text(_selectedLanguage == 'fr' ? 'Français' : 'English'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: 'fr', child: Text('Français')),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                }
              },
            ),
          ),

          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Thème'),
            subtitle: Text(_getThemeLabel(_selectedTheme)),
            trailing: DropdownButton<String>(
              value: _selectedTheme,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: 'light', child: Text('Clair')),
                DropdownMenuItem(value: 'dark', child: Text('Sombre')),
                DropdownMenuItem(value: 'system', child: Text('Système')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedTheme = value;
                  });
                }
              },
            ),
          ),

          const Divider(),

          _buildSectionHeader('À propos'),

          const ListTile(
            leading: Icon(Icons.info),
            title: Text('Version'),
            subtitle: Text('1.0.0'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getThemeLabel(String theme) {
    switch (theme) {
      case 'light':
        return 'Clair';
      case 'dark':
        return 'Sombre';
      case 'system':
      default:
        return 'Système';
    }
  }
}