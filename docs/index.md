# Welcome to the UGSEL Web documentation

This project is an application for managing school sports competitions.

## Where to start?

If you are a developer or proofreader, we recommend this path:

1. Understand our technical choices in the **[Software Architecture](architecture.md)**.
2. Check the code’s robustness via **[Testing Strategy](tests.md)**.
3. View the data schema in section **[Database](database.md)**.

If you are a user, we recommend the **[User Guide](user_guide.md)**.

---

## Features
- Sports management (Individual / Team)
- Management of competitions and championships
- Import of students (CSV)
- Complete administration interface

## Technical Stack
- **Backend**: Django 5 + Python 3.12
- **Database**: SQLite (Dev) / PostgreSQL (Prod)
- **Tests**: Pytest, Playwright (E2E), Pytest-BDD
- **Quality**: Flake8, Black, Radon (A+)

## Launch the project

```bash
docker compose up --build
```