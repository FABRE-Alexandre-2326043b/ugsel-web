# Base de Données

Le projet utilise une base relationnelle (SQLite en dev, PostgreSQL en prod).

## Modèles Principaux (`src.core.models`)

### Structure Sportive
* **Sport** : L'activité racine (ex: "Judo", "Athlétisme").
    * *Attributs* : `nom`, `caracteristique` (Indiv/Equipe).
* **Epreuve** : Une sous-division du sport (ex: "100m", "Saut en hauteur").
    * *Lien* : ForeignKey vers `Sport`.
* **Competition** : L'événement physique (ex: "Départemental 2024").
    * *Lien* : ManyToMany vers `Epreuve`.
* **Championnat** : Le regroupement logique (ex: "National Athlé").
    * *Lien* : ManyToMany vers `Competition`.

[Retour à l'accueil](index.md)
