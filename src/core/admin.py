from django.contrib import admin
from .models import Sport, Championnat, Competition, Epreuve

@admin.register(Sport)
class SportAdmin(admin.ModelAdmin):
    list_display = ('nom', 'caracteristique')
    list_filter = ('caracteristique',)

@admin.register(Epreuve)
class EpreuveAdmin(admin.ModelAdmin):
    list_display = ('nom', 'sport')
    list_filter = ('sport',)

@admin.register(Competition)
class CompetitionAdmin(admin.ModelAdmin):
    list_display = ('nom',)
    # Permet de sélectionner les épreuves facilement avec une double liste
    filter_horizontal = ('epreuves',) 

@admin.register(Championnat)
class ChampionnatAdmin(admin.ModelAdmin):
    list_display = ('nom', 'sport')
    list_filter = ('sport',)
    # Permet de sélectionner les compétitions facilement
    filter_horizontal = ('competitions',)