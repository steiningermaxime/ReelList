import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/widgets.dart';
import '../../data/models/favorite.dart';
import 'favorites_vm.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    final vm = ref.read(favoritesViewModelProvider.notifier);
    switch (_tabController.index) {
      case 0:
        vm.loadFavorites();
        break;
      case 1:
        vm.loadFavorites(status: FavoriteStatus.watchlist);
        break;
      case 2:
        vm.loadFavorites(status: FavoriteStatus.watched);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(favoritesViewModelProvider);
    final vm = ref.read(favoritesViewModelProvider.notifier);

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
      body: _buildContent(state, vm),
    );
  }

  Widget _buildContent(FavoritesState state, FavoritesViewModel vm) {
    if (state.isLoading) {
      return const Loader(message: 'Chargement...');
    }

    if (state.error != null) {
      return ErrorView(
        error: state.error!,
        onRetry: () => vm.loadFavorites(status: state.filter),
      );
    }

    if (state.favorites.isEmpty) {
      return _buildEmptyState(state.filter);
    }

    return RefreshIndicator(
      onRefresh: () => vm.loadFavorites(status: state.filter),
      child: ListView.builder(
        itemCount: state.favorites.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final favorite = state.favorites[index];
          return Dismissible(
            key: Key(favorite.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (_) => _confirmDelete(favorite),
            onDismissed: (_) => _deleteFavorite(favorite, vm),
            child: _buildFavoriteCard(favorite, vm),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(FavoriteStatus? filter) {
    IconData icon;
    String message;

    switch (filter) {
      case FavoriteStatus.watchlist:
        icon = Icons.bookmark_border;
        message = 'Aucun film dans votre liste à voir';
        break;
      case FavoriteStatus.watched:
        icon = Icons.check_circle_outline;
        message = 'Aucun film vu';
        break;
      default:
        icon = Icons.favorite_border;
        message = 'Aucun favori';
    }

    return EmptyStateView(icon: icon, message: message);
  }

  Widget _buildFavoriteCard(Favorite favorite, FavoritesViewModel vm) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: favorite.posterUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  favorite.posterUrl!,
                  width: 50,
                  height: 75,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 50,
                    height: 75,
                    color: Colors.grey[300],
                    child: const Icon(Icons.movie),
                  ),
                ),
              )
            : Container(
                width: 50,
                height: 75,
                color: Colors.grey[300],
                child: const Icon(Icons.movie),
              ),
        title: Text(
          favorite.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (favorite.releaseYear != null)
              Text('${favorite.releaseYear}'),
            if (favorite.personalRating != null)
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text('${favorite.personalRating}/5'),
                ],
              ),
            Text(
              favorite.status == FavoriteStatus.watched ? 'Vu' : 'À voir',
              style: TextStyle(
                color: favorite.status == FavoriteStatus.watched
                    ? Colors.green
                    : Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            if (favorite.status == FavoriteStatus.watchlist)
              const PopupMenuItem(
                value: 'watched',
                child: Row(
                  children: [
                    Icon(Icons.check_circle),
                    SizedBox(width: 8),
                    Text('Marquer comme vu'),
                  ],
                ),
              ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Supprimer', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'watched') {
              _markAsWatched(favorite, vm);
            } else if (value == 'delete') {
              _deleteFavorite(favorite, vm);
            }
          },
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(Favorite favorite) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer'),
        content: Text('Supprimer "${favorite.title}" de vos favoris ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _deleteFavorite(
    Favorite favorite,
    FavoritesViewModel vm,
  ) async {
    try {
      await vm.deleteFavorite(favorite.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${favorite.title} supprimé'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _markAsWatched(
    Favorite favorite,
    FavoritesViewModel vm,
  ) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _RatingDialog(favorite: favorite),
    );

    if (result != null && mounted) {
      try {
        await vm.markAsWatched(
          favorite.id,
          result['rating'] as int,
          result['comment'] as String?,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Film marqué comme vu'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}

class _RatingDialog extends StatefulWidget {
  const _RatingDialog({required this.favorite});

  final Favorite favorite;

  @override
  State<_RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<_RatingDialog> {
  int _rating = 3;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Noter le film'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Votre note :'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 32,
                ),
                onPressed: () => setState(() => _rating = index + 1),
              );
            }),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              labelText: 'Commentaire (optionnel)',
              hintText: 'Votre avis sur le film...',
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'rating': _rating,
              'comment': _commentController.text.trim().isEmpty
                  ? null
                  : _commentController.text.trim(),
            });
          },
          child: const Text('Valider'),
        ),
      ],
    );
  }
}