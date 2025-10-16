import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateProvider<Locale>((ref) => const Locale('fr'));

extension LocalizationExtension on BuildContext {
  String localizedText(String key) {
    final locale = ProviderScope.containerOf(this).read(localeProvider);
    
    final translations = {
      'fr': {
        'appTitle': 'ReelList',
        'login': 'Connexion',
        'logout': 'Déconnexion',
        'search': 'Recherche',
        'movies': 'Films',
        'favorites': 'Favoris',
        'settings': 'Paramètres',
        'searchMovies': 'Rechercher des films...',
        'addToFavorites': 'Ajouter aux favoris',
        'removeFromFavorites': 'Retirer des favoris',
        'watchlist': 'À voir',
        'watched': 'Vus',
        'all': 'Tous',
        'rating': 'Note',
        'comment': 'Commentaire',
        'save': 'Sauvegarder',
        'cancel': 'Annuler',
        'edit': 'Modifier',
        'delete': 'Supprimer',
        'error': 'Erreur',
        'retry': 'Réessayer',
        'loading': 'Chargement...',
        'noResults': 'Aucun résultat',
        'language': 'Langue',
        'theme': 'Thème',
        'lightTheme': 'Clair',
        'darkTheme': 'Sombre',
        'systemTheme': 'Système',
        'enterToken': 'Entrez votre token d\'accès',
        'tokenRequired': 'Le token est requis',
        'invalidToken': 'Token invalide',
        'networkError': 'Erreur réseau',
        'serverError': 'Erreur serveur',
        'unknownError': 'Erreur inconnue',
      },
      'en': {
        'appTitle': 'ReelList',
        'login': 'Login',
        'logout': 'Logout',
        'search': 'Search',
        'movies': 'Movies',
        'favorites': 'Favorites',
        'settings': 'Settings',
        'searchMovies': 'Search movies...',
        'addToFavorites': 'Add to favorites',
        'removeFromFavorites': 'Remove from favorites',
        'watchlist': 'Watchlist',
        'watched': 'Watched',
        'all': 'All',
        'rating': 'Rating',
        'comment': 'Comment',
        'save': 'Save',
        'cancel': 'Cancel',
        'edit': 'Edit',
        'delete': 'Delete',
        'error': 'Error',
        'retry': 'Retry',
        'loading': 'Loading...',
        'noResults': 'No results',
        'language': 'Language',
        'theme': 'Theme',
        'lightTheme': 'Light',
        'darkTheme': 'Dark',
        'systemTheme': 'System',
        'enterToken': 'Enter your access token',
        'tokenRequired': 'Token is required',
        'invalidToken': 'Invalid token',
        'networkError': 'Network error',
        'serverError': 'Server error',
        'unknownError': 'Unknown error',
      },
    };
    
    final localeKey = locale.languageCode;
    return translations[localeKey]?[key] ?? key;
  }
}

class AppLocales {
  static const List<Locale> supportedLocales = [
    Locale('fr'),
    Locale('en'),
  ];
  
  static const Locale defaultLocale = Locale('fr');
}