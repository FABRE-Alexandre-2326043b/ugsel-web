#!/bin/bash

# Couleurs pour la sortie console
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Démarrage de la construction de l'Usine Logicielle UGSEL ===${NC}"

# 1. CRÉATION DE L'ARBORESCENCE (SOLID & CLEAN ARCHITECTURE)
echo -e "${GREEN}1. Création de l'arborescence des dossiers...${NC}"
mkdir -p config
mkdir -p docs
mkdir -p src/core
mkdir -p src/competitions
mkdir -p src/users
mkdir -p src/services
mkdir -p src/static
mkdir -p src/templates
mkdir -p tests/unit
mkdir -p tests/integration
mkdir -p tests/e2e
mkdir -p tests/behavior

# Création des fichiers .gitkeep pour conserver les dossiers vides
touch src/services/.gitkeep
touch src/static/.gitkeep
touch src/templates/.gitkeep

# 2. CONFIGURATION DE LA QUALITÉ (LINTERS & TESTS)
echo -e "${GREEN}2. Génération de pyproject.toml (Ruff, Black, Pytest, Xenon)...${NC}"
cat <<EOT > pyproject.toml
[tool.black]
line-length = 88
target-version = ['py312']
exclude = '''
/(
    \.git
  | \.hg
  | \.mypy_cache
  | \.tox
  | \.venv
  | _build
  | buck-out
  | build
  | dist
  | migrations
)/
'''

[tool.ruff]
# Règles activées : Pyflakes (F), pycodestyle (E, W), isort (I), bandit (S), flake8-simplify (SIM)
select = ["E", "F", "W", "I", "S", "SIM"]
ignore = ["E501"] # La longueur de ligne est gérée par Black
exclude = ["migrations"]

[tool.ruff.per-file-ignores]
"tests/*" = ["S101"] # Autorise 'assert' dans les tests

[tool.pytest.ini_options]
DJANGO_SETTINGS_MODULE = "config.settings"
python_files = ["test_*.py", "*_test.py"]
addopts = "--cov=src --cov-report=html --cov-fail-under=80"
testpaths = ["tests"]

[tool.xenon]
max-absolute = "B"
max-modules = "A"
max-average = "A"
exclude = ["migrations/*", "tests/*"]
EOT

# 3. DÉPENDANCES PYTHON
echo -e "${GREEN}3. Création du requirements.txt...${NC}"
cat <<EOT > requirements.txt
# Core Framework
Django==5.0.1
psycopg2-binary==2.9.9
django-htmx==1.17.0

# Server
gunicorn==21.2.0

# Quality & Testing
pytest==8.0.0
pytest-django==4.7.0
pytest-cov==4.1.0
pytest-bdd==7.0.1
playwright==1.41.0
ruff==0.1.14
black==24.1.1
xenon==0.9.1
mypy==1.8.0

# Documentation
mkdocs==1.5.3
mkdocs-material==9.5.3
EOT

# 4. CONFIGURATION DOCKER
echo -e "${GREEN}4. Création du Dockerfile...${NC}"
cat <<EOT > Dockerfile
# Image légère et sécurisée
FROM python:3.12-slim

# Variables d'environnement pour Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Installation des dépendances système (pour Postgres)
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Répertoire de travail
WORKDIR /app

# Installation des dépendances Python
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copie du projet
COPY . /app/

# Création d'un utilisateur non-root pour la sécurité
RUN useradd -m ugseluser
USER ugseluser
EOT

echo -e "${GREEN}5. Création du docker-compose.yml...${NC}"
cat <<EOT > docker-compose.yml
services:
  web:
    build: .
    command: python manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/app
    ports:
      - "8000:8000"
    depends_on:
      - db
    environment:
      - DEBUG=1
      - SECRET_KEY=dev_secret_key_change_in_prod
      - DB_NAME=ugsel_db
      - DB_USER=ugsel_user
      - DB_PASSWORD=ugsel_password
      - DB_HOST=db

  db:
    image: postgres:15-alpine
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=ugsel_db
      - POSTGRES_USER=ugsel_user
      - POSTGRES_PASSWORD=ugsel_password

  docs:
    image: squidfunk/mkdocs-material
    ports:
      - "8001:8000"
    volumes:
      - .:/docs
    command: serve -a 0.0.0.0:8000

volumes:
  postgres_data:
EOT

# 5. GIT & ENVIRONNEMENT
echo -e "${GREEN}6. Initialisation Git et .gitignore...${NC}"
git init
cat <<EOT > .gitignore
__pycache__/
*.pyc
db.sqlite3
.env
.venv/
.pytest_cache/
htmlcov/
dist/
site/
.DS_Store
.idea/
.vscode/
postgres_data/
EOT

echo -e "${GREEN}7. Création de la documentation de base...${NC}"
cat <<EOT > mkdocs.yml
site_name: Documentation UGSEL Web
theme:
  name: material
nav:
  - Accueil: index.md
EOT

echo "# Bienvenue sur la Documentation UGSEL Refonte" > docs/index.md

echo -e "${BLUE}=== Terminé ! Votre usine logicielle est prête. ===${NC}"
echo -e "Pour lancer le projet :"
echo -e "1. Lancez les conteneurs : ${GREEN}docker compose up -d --build${NC}"
echo -e "2. Initialisez Django : ${GREEN}docker compose exec web django-admin startproject config .${NC}"
echo -e "3. Réorganisez les fichiers générés par Django vers le dossier config/ si nécessaire."