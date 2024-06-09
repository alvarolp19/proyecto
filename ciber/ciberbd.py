import os
import mysql.connector
from mysql.connector import Error
import json

def obtener_ultimo_archivo_json(directorio):
    lista_archivos = [archivo for archivo in os.listdir(directorio) if archivo.endswith('.json')]
    if lista_archivos:
        return max(lista_archivos, key=lambda archivo: os.path.getctime(os.path.join(directorio, archivo)))
    else:
        return None

def conectar_mysql(host, usuario, contraseña, base_datos):
    try:
        conexion = mysql.connector.connect(
            host=host,
            user=usuario,
            password=contraseña,
            database=base_datos
        )
        if conexion.is_connected():
            print("Conexión establecida correctamente.")
            return conexion
    except Error as e:
        print(f"Error al conectarse a MySQL: {e}")
        return None

def verificar_pais_existe(conexion, pais):
    try:
        cursor = conexion.cursor()
        sql_select = "SELECT COUNT(*) FROM paises_completos WHERE pais = %s"
        cursor.execute(sql_select, (pais,))
        result = cursor.fetchone()
        return result[0] > 0
    except Error as e:
        print(f"Error al verificar el país: {e}")
        return False

def insertar_datos(conexion, datos):
    try:
        cursor = conexion.cursor()
        sql_insert = "INSERT INTO ciber (Fecha, Pais, Victima, Enlace) VALUES (%s, %s, %s, %s)"
        for d in datos:
            if verificar_pais_existe(conexion, d['Pais']):
                val = (d['Fecha'], d['Pais'], d['Victima'], d['Enlace'])
                cursor.execute(sql_insert, val)
            else:
                print(f"País no encontrado en paises_completos: {d['Pais']}")
        conexion.commit()
        print(f"Se insertaron {cursor.rowcount} registros.")
    except Error as e:
        print(f"Error al insertar datos: {e}")

def main():
    # Cargar configuración desde config.json
    with open('config.json', 'r') as config_file:
        config = json.load(config_file)

    host = config['host']
    usuario = config['usuario']
    contraseña = config['contraseña']
    base_datos = config['base_datos']

    # Directorio donde se almacenan los archivos JSON (ruta relativa)
    directorio_json = os.path.join(os.path.dirname(__file__), 'registros_diarios')

    # Obtener el nombre del último archivo JSON en el directorio
    nombre_archivo_nuevas_entradas = obtener_ultimo_archivo_json(directorio_json)

    if nombre_archivo_nuevas_entradas:
        # Conexión a MySQL
        conexion = conectar_mysql(host, usuario, contraseña, base_datos)
        # Insertar datos en MySQL desde el archivo JSON
        if conexion:
            with open(os.path.join(directorio_json, nombre_archivo_nuevas_entradas), 'r') as archivo:
                nuevos_datos = json.load(archivo)
            insertar_datos(conexion, nuevos_datos)
            conexion.close()

if __name__ == "__main__":
    main()

