#!/bin/bash

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== 1. Analyse de la Complexité (McCabe) ===${NC}"
xenon --max-absolute B --max-modules A --max-average A src/

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK] Complexité validée.${NC}"
else
    echo -e "${RED}[ERREUR] Code trop complexe !${NC}"
    exit 1
fi

echo -e "${GREEN}=== 2. Index de Maintenabilité (Radon) ===${NC}"
radon mi src/ --min B