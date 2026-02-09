# Stratégie de Tests

Le projet maintient une couverture de code > 90%.

## Types de tests
1. **Unitaires (`tests/unit`)**: Vérifient chaque modèle isolément.
2. **Comportementaux (`tests/behavior`)**: Scénarios Gherkin (BDD).
3. **End-to-End (`tests/final`)**: Simulation utilisateur réel avec Playwright.

## Lancer les tests
```bash
docker compose exec web pytest
```

[Retour à l'accueil](index.md)