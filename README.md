# 🏆 UGSEL Web - Gestion des Compétitions Scolaires

![Python](https://img.shields.io/badge/Python-3.12-blue?style=flat-square&logo=python)
![Django](https://img.shields.io/badge/Django-5.0-green?style=flat-square&logo=django)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker)
![Tests](https://img.shields.io/badge/Tests-Pytest%20%7C%20Playwright-brightgreen?style=flat-square)
![Quality](https://img.shields.io/badge/Code%20Quality-A%2B-success?style=flat-square)

Application web permettant de gérer les compétitions sportives (individuelles et par équipe), les inscriptions des élèves et l'organisation des championnats pour l'UGSEL.

---

## 🚀 Démarrage Rapide

### Prérequis
* **Docker** et **Docker Compose** installés.
* C'est tout ! (Pas besoin de Python ou PostgreSQL sur votre machine).

### Installation

1. **Cloner le projet**
   ```bash
   git clone https://github.com/votre-compte/ugsel-web.git
   cd ugsel-web

2. **Lancer l'environnement (Build & Run)**

    docker compose up --build

   *La première fois, cela peut prendre quelques minutes pour construire les images et installer Playwright.*

3. **Accéder à l'application**
   * **Site Web** : [http://localhost:8000](http://localhost:8000)
   * **Administration** : [http://localhost:8000/admin](http://localhost:8000/admin)
     * *Login* : `admin`
     * *Password* : `password123`
   * **Documentation Technique** : [http://localhost:8001](http://localhost:8001)

---

## 🏗️ Architecture et Choix Techniques

Le projet suit une architecture modulaire respectant les principes **SOLID** et **KISS**.

* **Backend** : Django 5 (Python 3.12).
* **Base de Données** : SQLite (Dev) / PostgreSQL (Prod).
* **Frontend** : Django Templates (Admin) + HTMX (prévu).
* **Qualité** :
    * **Pre-commit Hook** : Un "Gardien" empêche tout commit si la qualité du code (Flake8, Radon) est insuffisante ou si les tests échouent.
    * **CI/CD** : Configuration prête pour GitLab CI / GitHub Actions.

### Structure du projet

    .
    ├── config/             # Réglages globaux (Settings, URLS)
    ├── src/
    │   └── core/           # Cœur métier (Models, Services)
    ├── tests/
    │   ├── unit/           # Tests unitaires (Models)
    │   ├── behavior/       # Tests BDD (Gherkin/Cucumber)
    │   └── final/          # Tests E2E (Playwright)
    ├── docs/               # Documentation MkDocs
    ├── docker-compose.yml  # Orchestration des conteneurs
    └── manage.py           # Point d'entrée Django

---

## 🧪 Stratégie de Tests

Le projet dispose d'une couverture de tests complète (> 90%).

Pour lancer les tests, utilisez la commande suivante dans un terminal séparé :

### 1. Tous les tests (Recommandé)

    docker compose exec web pytest

*Note : Si vous rencontrez une erreur "SynchronousOnlyOperation", utilisez :*

    docker compose exec -e DJANGO_ALLOW_ASYNC_UNSAFE=true web pytest

### 2. Tests par catégorie
* **Unitaires** (Logique métier) :

    docker compose exec web pytest tests/unit

* **Comportementaux** (BDD - Scénarios métier) :

    docker compose exec web pytest tests/behavior

* **End-to-End** (Interface Admin - Robot Play