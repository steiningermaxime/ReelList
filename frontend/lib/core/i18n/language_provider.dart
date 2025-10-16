import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/local_store.dart';

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier(this._localStore) : super(const Locale('fr')) {
    _loadLanguage();
  }

  final LocalStore _localStore;

  Future<void> _loadLanguage() async {
    final savedLang = _localStore.getLocale();
    if (savedLang != null) {
      state = Locale(savedLang);
    }
  }

  Future<void> setLanguage(String languageCode) async {
    state = Locale(languageCode);
    await _localStore.setLocale(languageCode);
  }

  String get tmdbLanguage {
    switch (state.languageCode) {
      case 'fr':
        return 'fr-FR';
      case 'en':
        return 'en-US';
      default:
        return 'fr-FR';
    }
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier(ref.watch(localStoreProvider));
});
