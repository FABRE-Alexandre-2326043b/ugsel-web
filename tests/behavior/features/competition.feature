Feature: Gestion des Compétitions
    En tant qu'administrateur, je veux organiser des compétitions
    pour que les élèves puissent s'inscrire.

    Scenario: Création d'une compétition de Judo
        Given Le sport "Judo" existe dans la base
        When Je crée une compétition "Départemental 2024" pour ce sport
        Then La compétition doit être enregistrée avec le sport "Judo"
        And La compétition doit avoir 0 épreuves pour l'instant