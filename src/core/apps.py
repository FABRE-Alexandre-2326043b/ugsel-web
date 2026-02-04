from django.apps import AppConfig

class CoreConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'src.core'
    label = 'core'  # C'est ce label qu'on utilise dans les commandes
