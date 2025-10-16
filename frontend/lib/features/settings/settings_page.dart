import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../core/app_theme.dart';
import '../../core/i18n/language_provider.dart';
import '../../core/i18n/l10n_extensions.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('settings')),
      ),
      body: ListView(
        children: [
          _buildSectionHeader(context, context.tr('appearance')),

          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.tr('language')),
            subtitle: Text(locale.languageCode == 'fr'
                ? context.tr('french')
                : context.tr('english')),
            trailing: DropdownButton<String>(
              value: locale.languageCode,
              underline: const SizedBox(),
              items: [
                DropdownMenuItem(value: 'fr', child: Text(context.tr('french'))),
                DropdownMenuItem(value: 'en', child: Text(context.tr('english'))),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(languageProvider.notifier).setLanguage(value);
                }
              },
            ),
          ),

          ListTile(
            leading: const Icon(Icons.palette),
            title: Text(context.tr('theme')),
            subtitle: Text(_getThemeLabel(context, themeMode)),
            trailing: DropdownButton<AppThemeMode>(
              value: themeMode,
              underline: const SizedBox(),
              items: [
                DropdownMenuItem(
                  value: AppThemeMode.light,
                  child: Text(context.tr('light')),
                ),
                DropdownMenuItem(
                  value: AppThemeMode.dark,
                  child: Text(context.tr('dark')),
                ),
                DropdownMenuItem(
                  value: AppThemeMode.system,
                  child: Text(context.tr('system')),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).state = value;
                }
              },
            ),
          ),

          const Divider(),

          _buildSectionHeader(context, context.tr('about')),

          ListTile(
            leading: const Icon(Icons.info),
            title: Text(context.tr('version')),
            subtitle: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
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

  String _getThemeLabel(BuildContext context, AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return context.tr('light');
      case AppThemeMode.dark:
        return context.tr('dark');
      case AppThemeMode.system:
        return context.tr('system');
    }
  }
}