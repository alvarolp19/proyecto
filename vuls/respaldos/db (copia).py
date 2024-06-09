import os

import mysql.connector

from mysql.connector import Error

import json



def obtener_ultimo_archivo_json():

    lista_archivos = [archivo for archivo in os.listdir() if archivo.endswith('.json')]

    if lista_archivos:

        return max(lista_archivos, key=os.path.getctime)

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



def insertar_datos(conexion, datos):

    try:

        cursor = conexion.cursor()

        sql_insert = "INSERT INTO Vulnerabilidades (Vuln_ID, Producto_ID, Resumen, Gravedad_CVSS) VALUES (%s, %s, %s, %s)"

        cursor.executemany(sql_insert, [(d['Vuln ID'], obtener_id_producto(conexion, d['Producto']), d['Resumen'], d['Gravedad de CVSS']) for d in datos])

        conexion.commit()

        print(f"Se insertaron {cursor.rowcount} registros.")

    except Error as e:

        print(f"Error al insertar datos: {e}")



def obtener_id_producto(conexion, nombre_producto):

    try:

        cursor = conexion.cursor()

        sql_select = "SELECT ID_Producto FROM Productos WHERE Nombre_Producto = %s"

        cursor.execute(sql_select, (nombre_producto,))

        resultado = cursor.fetchone()

        if resultado:

            return resultado[0]

        else:

            print(f"No se encontró el producto: {nombre_producto}")

            return None

    except Error as e:

        print(f"Error al obtener ID del producto: {e}")

        return None



# Configuración de la conexión a MySQL

host = 'localhost'

usuario = 'alp'

contraseña = 'qwerty'

base_datos = 'vuls'



# Obtener el nombre del último archivo JSON en el directorio

nombre_archivo_nuevas_entradas = obtener_ultimo_archivo_json()



if nombre_archivo_nuevas_entradas:

    # Conexión a MySQL

    conexion = conectar_mysql(host, usuario, contraseña, base_datos)



    # Insertar datos en MySQL desde el archivo JSON

    if conexion:

        with open(nombre_archivo_nuevas_entradas, 'r') as archivo:

            datos_json = json.load(archivo)

            insertar_datos(conexion, datos_json)

