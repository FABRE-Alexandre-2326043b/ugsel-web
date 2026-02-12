# Test Strategy

The project maintains code coverage > 90%.

## Types of tests
1. **Unitaires (`tests/unit>)**: Check each model separately.
2. **Behavioral (`tests/behavior`)*: Gherkin Scenarios (BDD).
3. **End-to-End (`tests/final>)**: Real user simulation with Playwright.

## Launch the tests
```bash
docker compose exec web pytest
``>

[Return to home page](index.md)