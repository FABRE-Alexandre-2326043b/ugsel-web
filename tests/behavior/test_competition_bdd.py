import pytest
from pytest_bdd import scenario, given, when, then, parsers
from src.core.models import Sport, Competition

@scenario('features/competition.feature', "Création d'une compétition de Judo")
def test_creation_competition():
    pass

@given(parsers.parse('Le sport "{nom_sport}" existe dans la base'), target_fixture="sport_context")
def creer_sport(nom_sport, db):
    return Sport.objects.create(nom=nom_sport, caracteristique="INDIV")

@when(parsers.parse('Je crée une compétition "{nom_compet}" pour ce sport'), target_fixture="competition_context")
def creer_competition(nom_compet, sport_context):
    assert sport_context is not None
    return Competition.objects.create(nom=nom_compet)


@then(parsers.parse('La compétition doit être enregistrée avec le sport "{nom_sport}"'))
def verifier_sport_competition(competition_context, nom_sport):
    assert Competition.objects.filter(pk=competition_context.pk).exists()
    assert Sport.objects.filter(nom=nom_sport).exists()


@then(parsers.parse('La compétition doit avoir {nb:d} épreuves pour l\'instant'))
def verifier_nb_epreuves(competition_context, nb):
    assert competition_context.epreuves.count() == nb