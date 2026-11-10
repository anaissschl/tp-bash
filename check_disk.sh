
#!/bin/bash

SEUIL=${1:-80}

UTILISATION=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Utilisation du disque : $UTILISATION%"
echo "Seuil defini : $SEUIL%"

if [ "$UTILISATION" -ge "$SEUIL" ]; then
    echo "ALERTE : espace disque insuffisant !"
    exit 1
else
    echo "OK : espace disque suffisant."
    exit 0
fi

