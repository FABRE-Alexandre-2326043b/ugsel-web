# Database

The project uses a relational database (SQLite in dev, PostgreSQL in production).

## Main Templates (`src.core.models>)

### Sports Structure
* **Sport**: The root activity (ex: "Judo", "Athletics").
    * *Attributes* : `name`, `characteristic` (Indiv/Team).
* **Event**: A subdivision of sport (ex: "100m", "High jump").
    * *Link* : ForeignKey to `Sport`.
* **Competition**: The physical event (e.g. "Departmental 2024").
    * *Link* : ManyToMany to `Test`.
* **Championship**: The logical grouping (e.g. "National Athletics").
    * *Link* : ManyToMany towards `Competition`.

[Return to home page](index.md)

