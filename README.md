# 🏆 UGSEL Web - Management of School Competitions


![Python](https://img.shields.io/badge/Python-3.12-blue?style=flat-square&logo=python)
![Django](https://img.shields.io/badge/Django-5.0-green?style=flat-square&logo=django)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker)
![Tests](https://img.shields.io/badge/Tests-Pytest%20%7C%20Playwright-brightgreen?style=flat-square)
![Quality](https://img.shields.io/badge/Code%20Quality-A%2B-success?style=flat-square)

Web application to manage sports competitions (individual and team), student registrations and the organization of championships for the UGSEL.

---

## Quick Start

### Prerequisites
* **Docker** and **Docker Compose** installed.
* That’s it! (No need for Python or PostgreSQL on your machine).

### Installation

1. **Clone the project**
   ```bash
   git clone https://github.com/votre-compte/ugsel-web.git
   cd ugsel-web
   ```

2. **Launch the environment (Build & Run)**
    ```bash
    docker compose up --build
    ```
   *The first time, it may take a few minutes to build the images and install Playwright.*

3. **Access the application**
   * **Website** : [http://localhost:8000](http://localhost:8000)
   * **Administration** : [http://localhost:8000/admin](http://localhost:8000/admin)
     * *Login* : `admin”
     * *Password* : `password123`
   * **Technical Documentation** : [http://localhost:8001](http://localhost:8001)

---

## Architecture and Technical Choices

The project follows a modular architecture respecting the principles **SOLID** and **KISS**.

* **Backend**: Django 5 (Python 3.12).
* **Database** : SQLite (Dev) / PostgreSQL (Prod).
* **Frontend** : Django Templates (Admin) + HTMX (planned).
* **Quality** :
    * **Pre-commit Hook** : A "Guardian" prevents any commit if the code quality (Flake8, Radon) is insufficient or if the tests fail.
    * **CI/CD** : Setup ready for GitHub Actions.

### Project structure

    .
    ├── config/   # Global settings (Settings, URLS)
    ├── src/
    │    └── core/   # Core business (Models, Services)
    ├── tests/
    │   ├── unit/   # Unit tests (Models)
    │   ├── behavior/   # BDD Tests (Gherkin/Cucumber)
    │   └── final/   # E2E Tests (Playwright)
    ├── docs/   # Documentation MkDocs
    ├── docker-compose.yml  # Orchestration of containers
    └── manage.py   # Django entry point

---

## Test Strategy

The project has complete test coverage (> 90%).

To run the tests, use the following command in a separate terminal:

### 1. All tests (Recommended)

```bash
docker compose exec web pytest
```

*Note: If you encounter a "SynchronousOnlyOperation" error, use :*

```bash
docker compose exec -e DJANGO_ALLOW_ASYNC_UNSAFE=true web pytest
```
### 2. Tests by category

```bash
docker compose exec web pytest tests/unit
```

* **Unitaries** (Business logic):
    ```bash
    docker compose exec web pytest tests/unit
    ```
* **Behavioral** (BDD - Business scenarios):
    ```bash
    docker compose exec web pytest tests/behavior
    ```
* **End-to-End** (Admin Interface - Robot Playwright):
    ```bash
    docker compose exec -e DJANGO_ALLOW_ASYNC_UNSAFE=true web pytest tests/final
    ```
---

## Management Orders

### Check Code Quality
To obtain a report on cyclomatic complexity and maintainability:

```bash
docker compose exec web bash check_quality.sh
```
---

## Documentation

A complete documentation (Architecture, User Guide, Database, Index, Tests) is automatically generated via **MkDocs**.
It is accessible on the port **8001** when the container turns.

---

## Author

 **Alexandre FABRE** - *Lead Developer*