# ReelList Backend

## 🚀 Installation & Lancement

### Prérequis
- Docker Desktop installé et en cours d'exécution
- Supabase CLI installé (`brew install supabase/tap/supabase`)

### Premier lancement (ou après un `git pull`)

```bash
# 1. Démarrer Supabase
supabase start

# 2. Appliquer les migrations (créer les tables)
supabase db reset
```

> **💡 Important** : À chaque `git pull` qui contient de nouvelles migrations, relancer `supabase db reset` pour mettre à jour la base de données.

### Commandes quotidiennes

#### Démarrer Supabase
```bash
supabase start
```

#### Arrêter Supabase
```bash
supabase stop
```

#### Voir le statut
```bash
supabase status
```

#### Réinitialiser (supprime toutes les données)
```bash
supabase stop --no-backup
supabase start
```

### URLs d'accès

Après le démarrage, Supabase sera accessible sur :
- **Studio (Dashboard)** : http://localhost:54323
- **API URL** : http://localhost:54321
- **Database** : postgresql://postgres:postgres@localhost:54322/postgres

### Credentials

Les credentials par défaut sont affichés après `supabase status` :
- **anon key** : Pour les appels API anonymes
- **service_role key** : Pour les appels API admin
- **Database password** : `postgres`

---

## 📝 Notes

- Les données sont persistées entre les redémarrages avec `supabase start`
- Utilisez `supabase stop --no-backup` pour un reset complet
- Les migrations sont dans le dossier `supabase/migrations/`
