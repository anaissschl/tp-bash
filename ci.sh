#!/bin/bash

set -Eeuo pipefail

URL="${1:-}"
DOSSIER="repo-ci"
LOG="ci.log"

# Fonction de journalisation
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG"
}

# Gestion des erreurs
trap 'log "Erreur pendant le pipeline"; exit 1' ERR

# Vérifier que l'URL est fournie
if [ -z "$URL" ]; then
    log "Erreur : URL du dépôt manquante"
    exit 1
fi

log "Début du pipeline CI"

# Cloner ou mettre à jour le dépôt
if [ -d "$DOSSIER/.git" ]; then
    log "Mise à jour du dépôt"
    git -C "$DOSSIER" pull
else
    log "Clonage du dépôt"
    git clone "$URL" "$DOSSIER"
fi

# Simulation des tests
log "Exécution des tests"

if [ -f "$DOSSIER/check_disk.sh" ]; then
    log "Tests réussis"
else
    log "Tests échoués"
    exit 1
fi

log "Pipeline terminé avec succès"
exit 0
