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

def obtener_actor_id(conexion, nombre_actor):
    try:
        cursor = conexion.cursor()
        sql_select = "SELECT id FROM Actores WHERE nombre = %s"
        cursor.execute(sql_select, (nombre_actor,))
        resultado = cursor.fetchone()
        if resultado:
            return resultado[0]
        else:
            return None
    except Error as e:
        print(f"Error al obtener ID del actor: {e}")
        return None

def insertar_actor(conexion, nombre_actor, url_actor):
    try:
        cursor = conexion.cursor()
        sql_insert = "INSERT INTO Actores (nombre, url) VALUES (%s, %s)"
        cursor.execute(sql_insert, (nombre_actor, url_actor))
        conexion.commit()
        return cursor.lastrowid
    except Error as e:
        print(f"Error al insertar actor: {e}")
        return None

def insertar_incidentes(conexion, datos):
    try:
        cursor = conexion.cursor()
        sql_insert = "INSERT INTO Incidentes (fecha, victima, actor_id, Pais_Victima) VALUES (%s, %s, %s, %s)"
        for d in datos:
            actor_id = obtener_actor_id(conexion, d['Actor'])
            if not actor_id:
                actor_id = insertar_actor(conexion, d['Actor'], 'N/A')
            cursor.execute(sql_insert, (d['Fecha'], d['Victima'], actor_id, d['Pais_Victima']))
        conexion.commit()
        print(f"Se insertaron {len(datos)} registros.")
    except Error as e:
        print(f"Error al insertar incidentes: {e}")

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
        insertar_incidentes(conexion, nuevos_datos)
        conexion.close()

