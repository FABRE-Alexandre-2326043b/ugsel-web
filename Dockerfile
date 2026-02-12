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