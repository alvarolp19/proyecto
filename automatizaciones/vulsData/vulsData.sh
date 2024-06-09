#!/bin/bash

# Ruta al script bdtodos.sh
ruta_script="proyecto/vuls/bdtodos.sh"

# Verificar si el script existe
if [ -f "$ruta_script" ]; then
    echo "Ejecutando bdtodos.sh..."
    # Cambiar al directorio del script y ejecutarlo
    (cd "$(dirname "$ruta_script")" && ./$(basename "$ruta_script"))
else
    echo "No se encontró el script bdtodos.sh en la ruta especificada."
fi

