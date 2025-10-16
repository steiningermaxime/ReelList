import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  String _selectedLanguage = 'fr';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Rechercher des films...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                    },
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  items: const [
                    DropdownMenuItem(value: 'fr', child: Text('🇫🇷 FR')),
                    DropdownMenuItem(value: 'en', child: Text('🇺🇸 EN')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Recherchez vos films préférés',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}