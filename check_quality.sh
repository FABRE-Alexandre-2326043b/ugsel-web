#!/bin/bash

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== 1. Analyse de la Complexité Cyclomatique (McCabe) ===${NC}"

docker compose exec web xenon --max-absolute B --max-modules A --max-average A src/

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK] Complexité maîtrisée.${NC}"
else
    echo -e "${RED}[ERREUR] Le code est trop complexe ! Simplifiez vos fonctions.${NC}"
    exit 1
fi

echo -e "${GREEN}=== 2. Calcul de l'Index de Maintenabilité (MI) ===${NC}"

docker compose exec web radon mi src/ --min B

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK] Index de maintenabilité Excellent (A) partout.${NC}"
else
    echo -e "${RED}[ATTENTION] Certains fichiers ont un index de maintenabilité faible (B, C ou D).${NC}"
    # exit 1 
fi