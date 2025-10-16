import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/debouncer.dart';
import '../../core/widgets/widgets.dart';
import 'search_vm.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(duration: const Duration(milliseconds: 300));

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchViewModelProvider);
    final vm = ref.read(searchViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Rechercher des films...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                _debouncer.run(() => vm.search(value));
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildContent(state, vm),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(SearchState state, SearchViewModel vm) {
    if (state.isLoading) {
      return const Loader(message: 'Recherche en cours...');
    }

    if (state.error != null) {
      return ErrorView(
        error: state.error!,
        onRetry: () => vm.search(state.query),
      );
    }

    if (state.query.isEmpty) {
      return const EmptyStateView(
        icon: Icons.search,
        message: 'Recherchez vos films préférés',
      );
    }

    if (state.movies.isEmpty) {
      return const EmptyStateView(
        icon: Icons.movie_outlined,
        message: 'Aucun film trouvé',
      );
    }

    return ListView.builder(
      itemCount: state.movies.length,
      itemBuilder: (context, index) {
        final movie = state.movies[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: movie.posterUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      movie.posterUrl!,
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
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (movie.releaseYear != null)
                  Text('${movie.releaseYear}'),
                if (movie.voteAverage != null)
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${movie.voteAverage!.toStringAsFixed(1)}/10'),
                    ],
                  ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _addToFavorites(movie, vm),
              tooltip: 'Ajouter aux favoris',
            ),
            onTap: () => _showMovieDetails(movie),
          ),
        );
      },
    );
  }

  Future<void> _addToFavorites(
    dynamic movie,
    SearchViewModel vm,
  ) async {
    try {
      await vm.addToFavorites(movie);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${movie.title} ajouté aux favoris'),
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

  void _showMovieDetails(dynamic movie) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            if (movie.overview != null && movie.overview!.isNotEmpty)
              Text(
                movie.overview!,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}