import os
import time
import json
from typing import List, Dict
import requests
import xml.etree.ElementTree as ET
from datetime import datetime

def extract_data_from_xml(xml_url: str) -> List[Dict[str, str]]:
    # Descargar el contenido del archivo XML
    response = requests.get(xml_url)
    # Verificar si la descarga fue exitosa
    if response.status_code == 200:
        # Parsear el contenido del XML
        root = ET.fromstring(response.content)
        # Lista para almacenar los datos extraídos
        extracted_data = []
        # Iterar sobre cada elemento 'item'
        for item in root.findall('.//item'):
            # Extraer datos del elemento 'item'
            title = item.find('title').text
            pub_date = datetime.strptime(item.find('pubDate').text, '%a, %d %b %Y %H:%M:%S %z').strftime('%Y-%m-%d')
            country = title.split('(')[-1].split(')')[0]
            victim_name = title.split(' - ')[0]
            link = item.find('link').text.split('?url=')[-1]
            # Agregar los datos extraídos a la lista
            extracted_data.append({
                'Fecha': pub_date,
                'Pais': country,
                'Victima': victim_name,
                'Enlace': link
            })
        return extracted_data
    else:
        # Mostrar un mensaje de error si la descarga falla
        print("Error al descargar el archivo XML:", response.status_code)
        return None

def load_records(filename: str) -> List[Dict[str, str]]:
    try:
        with open(filename, 'r', encoding='utf-8') as file:
            return json.load(file)
    except FileNotFoundError:
        return []

def save_records(data: List[Dict[str, str]], filename: str) -> None:
    with open(filename, 'w', encoding='utf-8') as file:
        json.dump(data, file, indent=4, ensure_ascii=False)

def main():
    xml_url = 'https://ransomware.live/cyberattacks.xml'
    registros_filename = 'registros.json'
    directorio_registros_diarios = 'registros_diarios'
    
    # Descargar los datos del XML y extraerlos
    data = extract_data_from_xml(xml_url)
    
    # Cargar registros existentes o inicializar una lista vacía si el archivo no existe
    registro_completo = load_records(registros_filename)
    
    # Filtrar los registros nuevos
    nuevas_entradas = [incidente for incidente in data if incidente not in registro_completo]
    
    # Agregar los registros nuevos al registro completo
    registro_completo.extend(nuevas_entradas)
    
    # Guardar el registro completo
    save_records(registro_completo, registros_filename)
    
    # Crear un directorio para los registros diarios si no existe
    if not os.path.exists(directorio_registros_diarios):
        os.makedirs(directorio_registros_diarios)
    
    # Guardar solo los registros nuevos en un archivo diario con el formato "registro_aaaa-mm-dd_hh-mm-ss.json"
    fecha_hora_actual = time.strftime("%Y-%m-%d_%H-%M-%S")
    nombre_archivo_nuevos = f"{directorio_registros_diarios}/registro_{fecha_hora_actual}.json"
    save_records(nuevas_entradas, nombre_archivo_nuevos)
    
    print(f"Datos almacenados en {registros_filename} y {nombre_archivo_nuevos}")

if __name__ == "__main__":
    main()

