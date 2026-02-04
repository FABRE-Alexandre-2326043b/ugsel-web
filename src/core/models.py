from django.db import models

class Sport(models.Model):
    TYPE_CHOICES = [
        ('INDIV', 'Individuel'),
        ('EQUIPE', 'Par Équipe'),
        ('MIXTE', 'Les deux'),
    ]

    nom = models.CharField(max_length=100)
    caracteristique = models.CharField(
        max_length=10, 
        choices=TYPE_CHOICES, 
        default='INDIV'
    )

    def __str__(self):
        return f"{self.nom} ({self.get_caracteristique_display()})"

class Epreuve(models.Model):
    """
    Exemple: 100m, Saut en hauteur (liée à un Sport)
    """
    nom = models.CharField(max_length=100)
    sport = models.ForeignKey(Sport, on_delete=models.CASCADE, related_name='epreuves')

    def __str__(self):
        return f"{self.nom} - {self.sport.nom}"

class Competition(models.Model):
    """
    Une compétition contient une ou plusieurs épreuve(s).
    """
    nom = models.CharField(max_length=200, help_text="Ex: Compétition Départementale 2024")
    epreuves = models.ManyToManyField(Epreuve, related_name='competitions')

    def __str__(self):
        return self.nom

class Championnat(models.Model):
    """
    Un championnat regroupe des compétitions autour d'un sport.
    """
    nom = models.CharField(max_length=200, help_text="Ex: Championnat National Athlétisme")
    sport = models.ForeignKey(Sport, on_delete=models.CASCADE)
    competitions = models.ManyToManyField(Competition, related_name='championnats')

    def __str__(self):
        return f"{self.nom} ({self.sport.nom})"