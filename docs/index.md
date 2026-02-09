# Bienvenue sur la documentation UGSEL Web

Ce projet est une application de gestion des compétitions sportives scolaires.

## Par où commencer ?

Si vous êtes développeur ou correcteur, nous vous conseillons ce parcours :

1.  Comprendre nos choix techniques dans l'**[Architecture Logicielle](architecture.md)**.
2.  Vérifier la robustesse du code via la **[Stratégie de Tests](tests.md)**.
3.  Consulter le schéma des données dans la section **[Base de Données](database.md)**.

Si vous êtes utilisateur, nous vous conseillons le **[Guide Utilisateur](user_guide.md)**.

---

## Fonctionnalités
- Gestion des sports (Individuel / Équipe)
- Gestion des compétitions et championnats
- Import des élèves (CSV)
- Interface d'administration complète

## Stack Technique
- **Backend**: Django 5 + Python 3.12
- **Base de données**: SQLite (Dev) / PostgreSQL (Prod)
- **Tests**: Pytest, Playwright (E2E), Pytest-BDD
- **Qualité**: Flake8, Black, Radon (A+)

## Lancer le projet

```bash
docker compose up --build
```