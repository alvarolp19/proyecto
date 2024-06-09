#!/bin/bash

# Obtener la lista de directorios en el directorio actual
directorios=$(find . -maxdepth 1 -type d -not -path '*/\.*')

# Iterar sobre cada directorio
for directorio in $directorios; do
    # Verificar si el directorio tiene un archivo db.py
    if [ -f "$directorio/db.py" ]; then
        echo "Ejecutando db.py en $directorio"
        # Cambiar al directorio y ejecutar db.py
        (cd "$directorio" && python3 db.py)
        echo "Finalizado"
    fi
done
