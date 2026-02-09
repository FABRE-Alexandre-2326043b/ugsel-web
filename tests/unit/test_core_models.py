import pytest
from django.db.utils import IntegrityError
from src.core.models import Sport, Epreuve, Competition, Championnat

@pytest.mark.django_db
class TestCoreModels:

    def test_creation_sport(self):
        """Vérifie qu'on peut créer un sport et que son affichage est correct"""
        # Action : Création
        judo = Sport.objects.create(nom="Judo", caracteristique="INDIV")
        basket = Sport.objects.create(nom="Basket", caracteristique="EQUIPE")

        # Assertion : Vérification du __str__ (formatage)
        assert str(judo) == "Judo (Individuel)"
        assert str(basket) == "Basket (Par Équipe)"

    def test_relation_epreuve_sport(self):
        """Vérifie qu'une épreuve est bien liée à un sport"""
        natation = Sport.objects.create(nom="Natation", caracteristique="INDIV")
        
        # On crée une épreuve liée à la natation
        epreuve_100m = Epreuve.objects.create(nom="100m Nage Libre", sport=natation)

        # Vérification
        assert epreuve_100m.sport == natation
        assert epreuve_100m.sport.nom == "Natation"
        assert str(epreuve_100m) == "100m Nage Libre - Natation"

    def test_workflow_competition(self):
        """Test complet : Sport -> Epreuve -> Compétition"""
        # Setup
        athle = Sport.objects.create(nom="Athlétisme")
        saut = Epreuve.objects.create(nom="Saut en longueur", sport=athle)
        course = Epreuve.objects.create(nom="100m Haies", sport=athle)
        
        # Création Compétition
        compet_departementale = Competition.objects.create(nom="Départemental 2024")
        
        # Ajout des épreuves (ManyToMany)
        compet_departementale.epreuves.add(saut, course)

        # Vérifications
        assert compet_departementale.epreuves.count() == 2
        assert saut in compet_departementale.epreuves.all()

    def test_championnat_regroupement(self):
        """Vérifie qu'un championnat regroupe bien des compétitions"""
        foot = Sport.objects.create(nom="Football", caracteristique="EQUIPE")
        
        compet_nord = Competition.objects.create(nom="Tournoi Nord")
        compet_sud = Competition.objects.create(nom="Tournoi Sud")
        
        championnat = Championnat.objects.create(nom="National Foot", sport=foot)
        championnat.competitions.add(compet_nord, compet_sud)

        assert championnat.competitions.count() == 2
        assert str(championnat) == "National Foot (Football)"
    
    def test_erreur_epreuve_sans_sport(self):
        """
        Vérifie qu'il est impossible de créer une épreuve sans sport.
        Le test réussit si une erreur d'intégrité (IntegrityError) est levée.
        """
        print("Tentative de création d'une épreuve orpheline...")

        # Capture de l'exception attendue
        with pytest.raises(IntegrityError):
            Epreuve.objects.create(nom="Epreuve Fantôme")