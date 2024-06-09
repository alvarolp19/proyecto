import os
import shutil
import mysql.connector

def crear_carpeta_y_script(nombre_producto):
    # Ruta base relativa donde se creará la nueva carpeta
    ruta_base = os.path.join(os.getcwd(), "vuls")
    ruta_producto = os.path.join(ruta_base, nombre_producto)
    
    # Crear carpeta con el nombre del producto
    try:
        os.mkdir(ruta_producto)
    except FileExistsError:
        print(f"La carpeta '{nombre_producto}' ya existe en la ruta '{ruta_base}'.")
        return

    # Copiar el archivo db.py en la carpeta con el nombre del producto
    shutil.copyfile(os.path.join(ruta_base, "db.py"), os.path.join(ruta_producto, "db.py"))

    # Conectar a la base de datos MySQL
    conexion = mysql.connector.connect(
        host="localhost",
        user="alp",
        password="qwerty",
        database="vuls"
    )
    cursor = conexion.cursor()

    # Insertar el nombre del producto en la tabla Productos
    cursor.execute("INSERT INTO Productos (Nombre_Producto) VALUES (%s)", (nombre_producto,))
    conexion.commit()

    # Copiar el script original al interior de la carpeta con el nombre del producto
    shutil.copyfile(os.path.join(ruta_base, "plantilla.py"), os.path.join(ruta_producto, f"{nombre_producto}.py"))

    # Modificar el script copiado con el nombre del producto
    script_path = os.path.join(ruta_producto, f"{nombre_producto}.py")

    with open(script_path, 'r') as file:
        script_lines = file.readlines()

    # Modificar las líneas relevantes del script
    for i, line in enumerate(script_lines):
        if 'incidente = {' in line:
            script_lines[i] = line.replace('termino', nombre_producto)
        elif 'url = ' in line:
            script_lines[i] = line.replace('termino', nombre_producto)
        elif 'nombre_archivo_registro =' in line:
            script_lines[i] = line.replace('termino', nombre_producto)
        elif 'nombre_archivo_nuevas_entradas =' in line:
            script_lines[i] = line.replace('termino', nombre_producto)

    # Escribir las modificaciones al script copiado
    with open(script_path, 'w') as file:
        file.writelines(script_lines)

    print(f"La carpeta '{nombre_producto}' y el script modificado han sido creados con éxito en '{ruta_producto}'.")

# Nombre del producto
nombre_producto = input("Ingrese el nombre del producto: ")

# Llamar a la función para crear la carpeta y el script modificado
crear_carpeta_y_script(nombre_producto)

