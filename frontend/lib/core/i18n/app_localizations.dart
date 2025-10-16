import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'fr': {
      'appTitle': 'ReelList',
      'search': 'Recherche',
      'movies': 'Films',
      'favorites': 'Favoris',
      'settings': 'Paramètres',
      'searchMovies': 'Rechercher des films...',
      'popularMovies': 'Films Populaires',
      'addToFavorites': 'Ajouter aux favoris',
      'all': 'Tous',
      'watchlist': 'À voir',
      'watched': 'Vus',
      'loading': 'Chargement...',
      'loadingPopularMovies': 'Chargement des films populaires...',
      'loadingSearch': 'Recherche en cours...',
      'noResults': 'Aucun résultat',
      'noMovies': 'Aucun film disponible',
      'searchYourFavorites': 'Recherchez vos films préférés',
      'noFavorites': 'Aucun favori',
      'noWatchlist': 'Aucun film dans votre liste à voir',
      'noWatched': 'Aucun film vu',
      'delete': 'Supprimer',
      'cancel': 'Annuler',
      'markAsWatched': 'Marquer comme vu',
      'rateMovie': 'Noter le film',
      'yourRating': 'Votre note :',
      'comment': 'Commentaire (optionnel)',
      'yourOpinion': 'Votre avis sur le film...',
      'validate': 'Valider',
      'deleteConfirm': 'Supprimer de vos favoris ?',
      'addedToFavorites': 'ajouté aux favoris',
      'deletedFromFavorites': 'supprimé',
      'markedAsWatched': 'Film marqué comme vu',
      'error': 'Erreur',
      'retry': 'Réessayer',
      'refresh': 'Actualiser',
      'year': 'Année',
      'synopsis': 'Synopsis',
      'appearance': 'Apparence',
      'language': 'Langue',
      'french': 'Français',
      'english': 'English',
      'theme': 'Thème',
      'light': 'Clair',
      'dark': 'Sombre',
      'system': 'Système',
      'about': 'À propos',
      'version': 'Version',
      'seen': 'Vu',
      'toWatch': 'À voir',
      'loadingMovies': 'Chargement des films...',
      'addFav': 'Favoris',
    },
    'en': {
      'appTitle': 'ReelList',
      'search': 'Search',
      'movies': 'Movies',
      'favorites': 'Favorites',
      'settings': 'Settings',
      'searchMovies': 'Search movies...',
      'popularMovies': 'Popular Movies',
      'addToFavorites': 'Add to favorites',
      'all': 'All',
      'watchlist': 'Watchlist',
      'watched': 'Watched',
      'loading': 'Loading...',
      'loadingPopularMovies': 'Loading popular movies...',
      'loadingSearch': 'Searching...',
      'noResults': 'No results',
      'noMovies': 'No movies available',
      'searchYourFavorites': 'Search your favorite movies',
      'noFavorites': 'No favorites',
      'noWatchlist': 'No movies in your watchlist',
      'noWatched': 'No watched movies',
      'delete': 'Delete',
      'cancel': 'Cancel',
      'markAsWatched': 'Mark as watched',
      'rateMovie': 'Rate movie',
      'yourRating': 'Your rating:',
      'comment': 'Comment (optional)',
      'yourOpinion': 'Your opinion about the movie...',
      'validate': 'Validate',
      'deleteConfirm': 'Remove from your favorites?',
      'addedToFavorites': 'added to favorites',
      'deletedFromFavorites': 'deleted',
      'markedAsWatched': 'Movie marked as watched',
      'error': 'Error',
      'retry': 'Retry',
      'refresh': 'Refresh',
      'year': 'Year',
      'synopsis': 'Synopsis',
      'appearance': 'Appearance',
      'language': 'Language',
      'french': 'Français',
      'english': 'English',
      'theme': 'Theme',
      'light': 'Light',
      'dark': 'Dark',
      'system': 'System',
      'about': 'About',
      'version': 'Version',
      'seen': 'Seen',
      'toWatch': 'To watch',
      'loadingMovies': 'Loading movies...',
      'addFav': 'Favorites',
    },
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['fr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
