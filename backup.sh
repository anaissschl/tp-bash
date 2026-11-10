
#!/bin/bash

set -Eeuo pipefail

# Dossiers
DOSSIER="$HOME/tp-bash/data"
DESTINATION="$HOME/tp-bash/backups"

# Date et heure
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Creation du dossier de sauvegarde
mkdir -p "$DESTINATION"

# Verification du dossier source
if [ ! -d "$DOSSIER" ]; then
    echo "ERREUR : le dossier n'existe pas." >&2
    exit 1
fi

# Nom de l'archive
ARCHIVE="$DESTINATION/backup_$DATE.tar.gz"

# Creation de la sauvegarde
echo "Debut de la sauvegarde..."

tar -czf "$ARCHIVE" -C "$HOME/tp-bash" data

echo "Archive creee : $ARCHIVE"

# Suppression des anciennes sauvegardes
for fichier in "$DESTINATION"/*.tar.gz; do
    if [ -f "$fichier" ]; then
        find "$fichier" -mtime +7 -delete
    fi
done

echo "Sauvegarde terminee avec succes."

exit 0
