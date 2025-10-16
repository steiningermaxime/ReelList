# ReelList Frontend

Application mobile Flutter pour gérer vos films favoris.

## 🚀 Installation

```bash
# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
```

## 📝 Scripts utiles


# Analyse du code
flutter analyze

# Tests
flutter test
```

## 🏗️ Architecture

- **data/models/** : Modèles avec JsonSerializable
- **data/services/** : Services API (TMDB + Supabase)
- **data/repositories/** : Repositories avec cache Hive
- **data/local/** : Stockage local (Hive boxes)
- **features/** : Pages et ViewModels par feature
- **core/** : Router, thèmes, i18n, widgets partagés

## 🔧 Configuration

- **API TMDB** : Clé configurée dans `lib/core/network/api_config.dart`
- **Supabase** : URL et clé dans `lib/core/network/api_config.dart`
- **Cache local** : Hive (initialisé dans `main.dart`)

