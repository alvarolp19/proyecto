import os
import mysql.connector
from mysql.connector import Error
import json

def obtener_ultimo_archivo_json(directorio='.'):
    lista_archivos = [archivo for archivo in os.listdir(directorio) if archivo.endswith('.json')]
    if lista_archivos:
        return max(lista_archivos, key=lambda archivo: os.path.getctime(os.path.join(directorio, archivo)))
    else:
        return None

def cargar_configuracion(ruta_config):
    try:
        with open(ruta_config, 'r') as config_file:
            return json.load(config_file)
    except (FileNotFoundError, json.JSONDecodeError) as e:
        print(f"Error al cargar la configuración: {e}")
        return None

def conectar_mysql(config):
    try:
        conexion = mysql.connector.connect(
            host=config['host'],
            user=config['usuario'],
            password=config['contraseña'],
            database=config['base_datos']
        )
        if conexion.is_connected():
            print("Conexión establecida correctamente.")
            return conexion
    except Error as e:
        print(f"Error al conectarse a MySQL: {e}")
    return None

def obtener_id_producto(conexion, nombre_producto):
    try:
        cursor = conexion.cursor()
        sql_select = "SELECT ID_Producto FROM Productos WHERE Nombre_Producto = %s"
        cursor.execute(sql_select, (nombre_producto,))
        resultado = cursor.fetchone()
        # Consumir todos los resultados pendientes
        while cursor.nextset():
            cursor.fetchall()
        cursor.close()
        if resultado:
            return resultado[0]
        else:
            print(f"No se encontró el producto: {nombre_producto}")
    except Error as e:
        print(f"Error al obtener ID del producto: {e}")
    return None

def insertar_datos(conexion, datos):
    try:
        cursor = conexion.cursor()
        sql_insert = "INSERT INTO Vulnerabilidades (Vuln_ID, Producto_ID, Resumen, Gravedad_CVSS) VALUES (%s, %s, %s, %s)"
        valores = []
        for d in datos:
            producto_id = obtener_id_producto(conexion, d['Producto'])
            if producto_id is not None:
                valores.append((d['Vuln ID'], producto_id, d['Resumen'], d['Gravedad de CVSS']))
        cursor.executemany(sql_insert, valores)
        conexion.commit()
        print(f"Se insertaron {cursor.rowcount} registros.")
        cursor.close()
    except Error as e:
        print(f"Error al insertar datos: {e}")
    except KeyError as e:
        print(f"Datos JSON mal formateados: {e}")

def main():
    nombre_archivo_nuevas_entradas = obtener_ultimo_archivo_json()

    if not nombre_archivo_nuevas_entradas:
        print("No se encontró ningún archivo JSON.")
        return

    config = cargar_configuracion('../config.json')
    if not config:
        return

    conexion = conectar_mysql(config)
    if not conexion:
        return

    try:
        with open(nombre_archivo_nuevas_entradas, 'r') as archivo:
            datos_json = json.load(archivo)
            insertar_datos(conexion, datos_json)
    except (FileNotFoundError, json.JSONDecodeError) as e:
        print(f"Error al leer el archivo JSON: {e}")
    finally:
        if conexion.is_connected():
            conexion.close()
            print("Conexión cerrada.")

if __name__ == "__main__":
    main()

