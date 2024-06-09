import os
import json
import datetime

def ejecutar_scripts_productos(directorio_base):
    productos = [nombre for nombre in os.listdir(directorio_base) if os.path.isdir(os.path.join(directorio_base, nombre))]
    
    for producto in productos:
        script_path = os.path.join(directorio_base, producto, f"{producto}.py")
        if os.path.exists(script_path):
            print(f"Ejecutando el script para {producto}...")
            os.system(f"python3 {script_path}")
        else:
            print(f"No se encontró un script para {producto} en el directorio {os.path.join(directorio_base, producto)}.")

# Directorio base donde se encuentran los directorios de productos
directorio_base = os.path.dirname(os.path.abspath(__file__))

# Ejecutar los scripts de los productos
ejecutar_scripts_productos(directorio_base)
