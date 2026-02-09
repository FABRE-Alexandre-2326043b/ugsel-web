# Architecture Logicielle

Le projet respecte les principes **SOLID** et une architecture modulaire.

## Structure des Dossiers
- `config/`: Réglages globaux (Settings, URLS)
- `src/core/`: Application principale (Modèles, Commandes)
- `tests/`: Stratégie de tests complète (Unit, Behavior, E2E)

## Diagramme de Classe (Simplifié)
- **Sport**: Définit l'activité (ex: Judo, Foot)
- **Epreuve**: Une sous-catégorie (ex: 100m, Saut)
- **Competition**: L'événement physique
- **Championnat**: Le regroupement logique

[Retour à l'accueil](index.md)