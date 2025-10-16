import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tous'),
            Tab(text: 'À voir'),
            Tab(text: 'Vus'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFavoritesList('all'),
          _buildFavoritesList('watchlist'),
          _buildFavoritesList('watched'),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(String status) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            status == 'watchlist'
                ? Icons.bookmark_border
                : status == 'watched'
                    ? Icons.check_circle_outline
                    : Icons.favorite_border,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            status == 'watchlist'
                ? 'Aucun film dans votre liste à voir'
                : status == 'watched'
                    ? 'Aucun film vu'
                    : 'Aucun favori',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}