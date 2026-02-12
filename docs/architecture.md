# Software Architecture

The project respects the principles **SOLID** and a modular architecture.

## Folder Structure
- `config/>: Global settings (Settings, URLS)
- `src/core/>: Main application (Templates, Commands)
- `tests/>: Complete test strategy (Unit, Behavior, E2E)

## Class Diagram (Simplified)
- **Sport**: Defines the activity (ex: Judo, Foot)
- **Test**: A sub-category (ex: 100m, Jump)
- **Competition**: The physical event
- **Championship**: The logical grouping

[Return to home page](index.md)